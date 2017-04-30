require 'spec_helper'

RSpec.describe Beacon::States::Ping do
  describe '#call' do
    context 'server unreachable and no Internet connection' do
      it 'is Offline' do
        stub_request(:put, 'http://0.0.0.0/api/v1/satellites/')
          .to_raise(SocketError)
        stub_request(:head, 'http://example.com/')
          .to_raise(SocketError)

        next_state = described_class.new.call

        expect(next_state).to eq Beacon::States::Offline
      end
    end

    context 'server unreachable but online' do
      it 'is Failure' do
        stub_request(:put, 'http://0.0.0.0/api/v1/satellites/')
          .to_raise(SocketError)
        stub_request(:head, 'http://example.com/')
          .to_return(status: 200)

        next_state = described_class.new.call
        expect(next_state).to eq Beacon::States::Failure
      end
    end

    context 'server reachable but failed' do
      it 'is Failure and does not check Internet connectivity' do
        stub_request(:put, 'http://0.0.0.0/api/v1/satellites/')
          .to_return(status: 500)

        next_state = described_class.new.call
        expect(next_state).to eq Beacon::States::Failure
      end
    end

    context 'server available' do
      it 'sends system data as JSON' do
        expect(Beacon::System).to receive(:df).and_return 'system df'
        expect(Beacon::System).to receive(:free).and_return 'system free'
        expect(Beacon::System).to receive(:uptime).and_return 'system uptime'
        expect(Beacon::System).to receive(:uname).and_return 'system uname'
        expected_body = {
          satellite: {
            disk: 'system df',
            memory: 'system free',
            ruby: RUBY_DESCRIPTION,
            system: 'system uname',
            uptime: 'system uptime',
            version: Beacon::Version::VERSION
          }
        }
        expected_headers = {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Ruby'
        }
        stub_request(:put, 'http://0.0.0.0/api/v1/satellites/')
          .with(body: expected_body.to_json, headers: expected_headers)
          .to_return(status: 201)

        next_state = described_class.new.call
        expect(next_state).to eq Beacon::States::Success
      end
    end
  end
end
