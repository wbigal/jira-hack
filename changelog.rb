require 'csv'

Dir['./app/**/*.rb'].each { |f| require f }

# Sprint 87: Spt#15

current_sprint_id = 87
issues = Clients::Jira::CurrentSprint::Issues::Get.call(current_sprint_id)

changelogs = []

def extract_status_changelog(issue)
  issue_key = issue['key']

  changelog = {
    key: issue_key,
    'to do': nil,
    'dev wip': nil,
    'code review': nil,
    'ready to qa': nil,
    'qa wip': nil,
    'ready to merge': nil,
    'done': nil

  }

  Clients::Jira::Issues::Changelog::Get.call(issue_key)['values'].each do |value|
    status_changed = DateTime.parse(value['created'])

    value['items'].each do |item|
      next if item['field'] != 'status'

      changelog[item['toString'].downcase.to_sym] = status_changed.strftime('%d/%m/%Y')
    end
  end

  changelog
end

issues['completedIssues'].each do |issue|
  changelogs << extract_status_changelog(issue)
end

issues['issuesNotCompletedInCurrentSprint'].each do |issue|
  changelogs << extract_status_changelog(issue)
end

CSV.open("./data/results/sprint-#{current_sprint_id}.csv", "w") do |csv|
  csv << [
    "Key",
    "Dev WIP",
    "Code Review",
    "Ready to QA",
    "QA WIP",
    "Ready to Merge",
    "Done"
  ]

  changelogs.each do |changelog|
    csv << [
      changelog[:key],
      changelog[:'dev wip'],
      changelog[:'code review'],
      changelog[:'ready to qa'],
      changelog[:'qa wip'],
      changelog[:'ready to merge'],
      changelog[:'done']
    ]
  end
end
