require 'minitest/autorun'
require 'minitest/pride'
require 'pathname'

root_path = Pathname.new(__FILE__).join('../..').expand_path

$LOAD_PATH << root_path.join('lib')
require 'beacon'

Beacon.config.logger = Logger.new(root_path.join('log', 'test.log'))
