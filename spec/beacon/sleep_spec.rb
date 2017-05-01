require 'spec_helper'

RSpec.describe Beacon::Sleep do

  describe '.call' do
    it 'proxies to the real sleep' do
      expect(Kernel).to receive(:sleepy).with 2
      described_class.call 2
    end
  end

end
