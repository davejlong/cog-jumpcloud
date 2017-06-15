# frozen_string_literal: true

require_relative 'base'
require 'json'

module JumpCloud
  ##
  ## Users API Resource
  ##
  class Users < Base
    PATH = "#{BASE_PATH}/systemusers"

    def create(username: nil, email: nil)
      body = { username: username, email: email }
      response = handle http_client.post(PATH, body.to_json, headers)
      map_item response
    end

    def self.create(config, opts); new(config).create(opts); end

    private

    def path; PATH; end
  end
end
