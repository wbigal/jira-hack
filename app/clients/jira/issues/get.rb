module Clients
  module Jira
    module Issues
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
          "https://#{domain}.atlassian.net/rest/api/2/issue/#{issue_key}"
        end
      end
    end
  end
end
