# frozen_string_literal: true

require 'jump_cloud/config'

%w(users systems tags commands command_results)
  .each { |resource| require "jump_cloud/#{resource}" }
