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
require 'cucumber/rspec/doubles'
require 'rspec/core'
require 'rspec/mocks'

Aruba.configure do |config|
  config.command_launcher = :in_process
  config.main_class = Codewars::Runner
end

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
