require 'spec_helper'

describe Beacon::Loop do
  describe '#state' do
    it 'is an instance of State' do
      instance = Beacon::Loop.new
      assert_instance_of Beacon::State, instance.send(:state)
    end
  end
end
