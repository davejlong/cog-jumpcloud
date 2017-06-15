# frozen_string_literal: true

require_relative 'base'

module JumpCloud
  ##
  ## Commands API Resource
  ##
  class Commands < Base
    PATH = "#{BASE_PATH}/commands"

    private

    def path; PATH; end

    def map_item(item)
      super

      item['command_id'] = item['response.id']
      item['output'] = item['response.data.output']
      item
    end
  end
end
