require 'spec_helper'

RSpec.describe Beacon::State, :awake do
  describe '#state' do
    it 'is Ping' do
      instance = Beacon::State.new
      expect(instance.state).to eq Beacon::States::Ping
    end
  end

  describe '#state=' do
    it 'sets the state' do
      instance = Beacon::State.new
      instance.state = :something
      expect(instance.state).to eq :something
    end
  end

  describe '#call' do
    describe 'changing to another state' do
      it 'replaces the current state' do
        instance = Beacon::State.new
        instance.state = Beacon::States::Four
        instance.call
        expect(instance.state).to eq Beacon::States::Three
      end
    end
  end
end
