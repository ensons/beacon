require 'spec_helper'

describe Beacon::States::Ping do
  describe '#call' do
    describe 'server unreachable and no Internet connection' do
      it 'is Offline' do
        next_state = Beacon::States::Ping.new.call
        assert_equal Beacon::States::Offline, next_state
      end
    end

    #describe 'server unreachable but online' do
    #  it 'is Failure' do
    #    next_state = Beacon::States::Ping.new.call
    #    assert_equal Beacon::States::Failure, next_state
    #  end
    #end
  end
end
