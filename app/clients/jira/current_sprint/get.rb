module Clients
  module Jira
    module CurrentSprint
      class Get < Jira::Base
        def call
          body['values']&.first
        end

        private

        def url
          "https://#{domain}.atlassian.net/rest/agile/1.0/board/#{board_id}/sprint"
        end

        def params
          { state: 'active' }
        end
      end
    end
  end
end
