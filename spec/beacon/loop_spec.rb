require 'spec_helper'

RSpec.describe Beacon::Loop do
  describe '#state' do
    it 'is an instance of State' do
      looper = Beacon::Loop.new
      expect(looper.send(:state)).to be_instance_of Beacon::State
    end
  end
end
