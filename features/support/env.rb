require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '._api/'
end

require 'aruba/cucumber'
require 'aruba/in_process'
require 'codewars/runner'

Aruba.configure do |config|
  config.command_launcher = :in_process
  config.main_class = Codewars::Runner
end
