require 'spec_helper'

RSpec.describe Beacon::States::Ping do
  describe '#call' do
    context 'server unreachable and no Internet connection' do
      it 'is Offline' do
        stub_request(:put, 'http://0.0.0.0/api/v1/satellites/')
          .to_raise(SocketError)
        stub_request(:head, 'http://example.com/')
          .to_raise(SocketError)

        next_state = Beacon::States::Ping.new.call

        expect(next_state).to eq Beacon::States::Offline
      end
    end

    context 'server unreachable but online' do
      it 'is Failure' do
        stub_request(:put, 'http://0.0.0.0/api/v1/satellites/')
          .to_raise(SocketError)
        stub_request(:head, 'http://example.com/')
          .to_return(status: 200)

        next_state = Beacon::States::Ping.new.call
        expect(next_state).to eq Beacon::States::Failure
      end
    end
  end
end
