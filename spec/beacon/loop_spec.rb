require 'spec_helper'

RSpec.describe Beacon::Loop do
  describe '#state' do
    it 'is an instance of State' do
      looper = described_class.new
      expect(looper.send(:state)).to be_instance_of Beacon::State
    end
  end

  describe '#call' do
    context 'exception handling' do
      it 'logs the error' do
        looper = described_class.new
        allow(looper).to receive(:loop).and_yield

        state = double(:state)
        expect(looper).to receive(:state).and_return state
        expect(state).to receive(:call).and_raise ArgumentError, 'Kaboom'

        expect(Beacon::Sleep).to receive(:call).with 10
        messages = []
        expect(Beacon::Log).to receive(:error).twice do |&block|
          messages << block.call
        end

        looper.call

        expect(messages.size).to eq 2
        expect(messages[0]).to include 'ArgumentError'
        expect(messages[0]).to include 'Kaboom'
        expect(messages[1].join).to include 'loop.rb'
      end
    end

    context 'exception in exception handling' do
      it 'writes the error to STDOUT and sleeps' do
        looper = described_class.new
        allow(looper).to receive(:loop).and_yield

        state = double(:state)
        expect(looper).to receive(:state).and_return state
        expect(state).to receive(:call).and_raise ArgumentError, 'Bam'

        expect(Beacon::Sleep).to receive(:call).and_raise ArgumentError, 'Boom'
        expect(looper).to receive(:puts) do |message|
          expect(message.to_s).to include 'Boom'
        end
        expect(looper).to receive(:sleep).with 10

        looper.call
      end
    end
  end
end
