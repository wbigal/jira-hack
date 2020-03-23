module Clients
  module Jira
    module CurrentSprint
      module Issues
        class Get < Jira::Base
          attr_reader :sprint_id

          def initialize(sprint_id)
            @sprint_id = sprint_id
          end

          def call
            body['contents']
          end

          private

          def url
            "https://#{domain}.atlassian.net/rest/greenhopper/1.0/rapid/charts/sprintreport"
          end

          def params
            {
              rapidViewId: board_id,
              sprintId: sprint_id
            }
          end
        end
      end
    end
  end
end
