# frozen_string_literal: true

require 'net/http'

module CogCmd
  module JumpCloud
    ##
    ## Helpers to use for the API
    ##
    module Helpers
      API = 'console.jumpcloud.com'
      PORT = 443
      BASE_PATH = '/api'

      def http_client
        http = Net::HTTP.new API, PORT
        http.use_ssl = true
        http
      end

      def headers
        {
          'x-api-key' => api_key,
          'accept' => 'application/json',
          'content-type' => 'application/json'
        }
      end

      def api_key
        key = ENV.key?('COG_OPT_ACCOUNT') ? "_#{ENV['COG_OPT_ACCOUNT']}" : ''
        ENV["JUMPCLOUD_API_KEY#{key.upcase}"]
      end

      def subcommand
        request.args.first
      end

      def results(body)
        JSON.parse(body)['results'].map do |result|
          result['id'] = result['_id']
          result
        end
      end
    end
  end
end
