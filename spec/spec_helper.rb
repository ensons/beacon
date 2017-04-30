require 'pathname'
require 'webmock/rspec'
require 'beacon'

root_path = Pathname.new(__FILE__).join('../..').expand_path
test_logger = Logger.new root_path.join('log', 'test.log')
test_logger.formatter = Beacon.config.send(:default_logger_formatter)

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.color = true
  config.order = :random if ENV['CI']

  config.before :each do
    Beacon.configure do |beacon_config|
      beacon_config.delay = 0
      beacon_config.logger = test_logger
      beacon_config.endpoint = 'http://0.0.0.0'
    end
  end

  config.before :each, :awake do
    allow(Beacon::Sleep).to receive(:call)
  end
end
