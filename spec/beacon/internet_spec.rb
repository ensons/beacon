require 'spec_helper'

RSpec.describe Beacon::Internet do
  describe '.connect' do
    context 'no connection' do
      it 'is false' do
        stub_request(:head, 'http://example.com/').to_return(status: 500)
        online = described_class.connect
        expect(online).to be false
      end
    end
  end
end
