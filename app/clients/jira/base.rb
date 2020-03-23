require 'json'
require 'rest-client'

module Clients
  module Jira
    class Base
      def self.call(*args)
        new(*args).call
      end

      protected

      def request
        @request ||= RestClient.get(url, headers)
      end

      def headers
        { params: params, authorization: ENV['JIRA_TOKEN'] }
      end

      def params
        {}
      end

      def body
        JSON.parse(request.body)
      end

      def domain
        ENV['JIRA_DOMAIN']
      end

      def board_id
        ENV['JIRA_BOARD_ID']
      end
    end
  end
end
