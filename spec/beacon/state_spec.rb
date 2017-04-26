require 'spec_helper'

describe Beacon::State do
  describe '#state' do
    it 'is Ping' do
      instance = Beacon::State.new
      assert_equal Beacon::States::Ping, instance.state
    end
  end

  describe '#state=' do
    it 'sets the state' do
      instance = Beacon::State.new
      instance.state = :something
      assert_equal :something, instance.state
    end
  end

  describe '#call' do
    describe 'changing to another state' do
      it 'replaces the current state' do
        instance = Beacon::State.new
        instance.state = Beacon::States::Four
        instance.call
        assert_equal Beacon::States::Three, instance.state
      end
    end
  end
end
