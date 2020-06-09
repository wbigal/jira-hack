module Clients
  module Jira
    module Issues
      module Changelog
        class Get < Jira::Base
          attr_reader :issue_key

          def initialize(issue_key)
            @issue_key = issue_key
          end

          def call
            body
          end

          private

          def url
            "https://#{domain}.atlassian.net/rest/api/2/issue/#{issue_key}/changelog"
          end
        end
      end
    end
  end
end
