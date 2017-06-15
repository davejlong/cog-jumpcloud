# frozen_string_literal: true

require_relative 'base'

module JumpCloud
  ##
  ## Tags API Resource
  ##
  class Tags < Base
    PATH = "#{BASE_PATH}/tags"

    private

    def path; PATH; end
  end
end
