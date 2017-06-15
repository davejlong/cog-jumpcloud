# frozen_string_literal: true

# Add the lib directory to the load path
libdir = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

# Set load path for gems installed with "bundle install --standalone" or
# fallback to good 'ol bundler
begin
  require_relative 'bundle/bundler/setup'
rescue LoadError
  require 'bundler'
  Bundler.setup
end

require 'jump_cloud'

def config
  JumpCloud::Config.new(api_key: `cat .api_key`.strip)
end
