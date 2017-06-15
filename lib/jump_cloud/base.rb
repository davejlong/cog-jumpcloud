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

    def list(limit: 10, skip: 0)
      req_path = "#{path}?limit=#{limit}&skip=#{skip}"
      response = handle http_client.get(req_path, headers)
      response['results'].map! { |item| map_item(item) }
      response
    end

    def get(id)
      response = handle http_client.get("#{path}/#{id}", headers)
      map_item response
    end

    def self.list(config, opts); new(config).list(opts); end
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
      unless response.code.to_i == 200
        raise NetError, "Received #{response.code} from API"
      end
      JSON.parse response.body
    end

    def map_item(item)
      item['id'] = item['_id']
      item
    end

    def path; raise 'Path method must be overriden in resource'; end
  end
end
