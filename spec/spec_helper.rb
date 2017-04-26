require 'minitest/autorun'
require 'minitest/pride'
require 'pathname'

begin
  require 'webmock'
rescue LoadError => exception
  puts
  puts 'Please run `gem install webmock`'
  puts
  #raise exception
end

root_path = Pathname.new(__FILE__).join('../..').expand_path

$LOAD_PATH << root_path.join('lib')
require 'beacon'

test_logger = Logger.new root_path.join('log', 'test.log')
test_logger.formatter = Beacon.config.send(:default_logger_formatter)

Beacon.configure do |config|
  config.delay = 0
  config.logger = test_logger
  config.endpoint = 'http://0.0.0.0'
end
