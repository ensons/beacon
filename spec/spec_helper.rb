require 'pathname'
require 'webmock'

root_path = Pathname.new(__FILE__).join('../..').expand_path
#
#$LOAD_PATH << root_path.join('lib')
require 'beacon'

test_logger = Logger.new root_path.join('log', 'test.log')
test_logger.formatter = Beacon.config.send(:default_logger_formatter)

RSpec.configure do |config|

  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.color = true
  config.order = :random if ENV['CI']

  config.before :each do
    Beacon.configure do |config|
      config.delay = 0
      config.logger = test_logger
      config.endpoint = 'http://0.0.0.0'
    end
  end

end
