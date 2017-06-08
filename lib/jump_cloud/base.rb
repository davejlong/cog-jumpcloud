# frozen_string_literal: true

require 'net/http'
require 'json'
require 'jump_cloud/net_error'

module JumpCloud
  ##
  ## Base of API resources
  ##
  class Base
    attr_accessor :config

    API = 'console.jumpcloud.com'
    PORT = 443
    BASE_PATH = '/api'

    def initialize(config)
      @config = config
    end

    def list
      response = handle http_client.get(path, headers)
      response['results'].map! { |item| map_item(item) }
      response
    end

    def get(id)
      response = handle http_client.get("#{path}/#{id}", headers)
      map_item response
    end

    def self.list(config); new(config).list; end
    def self.get(config, id); new(config).get(id); end

    private

    def http_client
      http = Net::HTTP.new API, PORT
      http.use_ssl = true
      http
    end

    def headers
      {
        'x-api-key' => @config.api_key,
        'accept' => 'application/json',
        'content-type' => 'application/json'
      }
    end

    def handle(response)
      if response.code.to_i == 200
        JSON.parse response.body
      else
        raise NetError, "Received #{response.code} from API"
      end
    end

    def map_item(item)
      item['id'] = item['_id']
      item
    end

    def path; raise 'Path method must be overriden in resource'; end
  end
end
