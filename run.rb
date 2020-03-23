Dir['./app/**/*.rb'].each { |f| require f }

current_sprint = Clients::Jira::CurrentSprint::Get.call
issues = Clients::Jira::CurrentSprint::Issues::Get.call(current_sprint['id'])

subtasks = []

issues['completedIssues'].each do |issue|
  subtasks.concat(Clients::Jira::Issues::Get.call(issue['key'])['fields']['subtasks'])
end

issues['issuesNotCompletedInCurrentSprint'].each do |issue|
  subtasks.concat(Clients::Jira::Issues::Get.call(issue['key'])['fields']['subtasks'])
end

puts "Total subtasks: #{subtasks.size}"
puts "To Do subtasks: #{subtasks.select { |subtask| subtask['fields']['status']['name'].downcase != 'done' }.count}"
