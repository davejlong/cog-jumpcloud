# frozen_string_literal: true

require_relative 'base'

module JumpCloud
  ##
  ## Systems API Resource
  ##
  class Systems < Base
    PATH = "#{BASE_PATH}/systems"

    private

    def path; PATH; end
  end
end
