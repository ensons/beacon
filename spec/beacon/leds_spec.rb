require 'spec_helper'

RSpec.describe Beacon::Leds, :awake do
  describe '.blink!' do
    it 'proxies to the LED' do
      led = instance_double 'Beacon::Led'
      expect(led).to receive(:blink).with(times: 1)
      expect(Beacon::Led).to receive(:new).and_return led
      described_class.blink! 1
    end
  end

  describe '.stare!' do
    it 'proxies to the LED' do
      led = instance_double 'Beacon::Led'
      expect(led).to receive(:blink).with(duration: 3)
      expect(Beacon::Led).to receive(:new).and_return led
      described_class.stare!
    end
  end

  describe '.flash!' do
    it 'proxies to the LED' do
      led = instance_double 'Beacon::Led'
      expect(led).to receive(:blink).with(times: 2, duration: 0.7, pause: 0.3)
      expect(Beacon::Led).to receive(:new).and_return led
      described_class.flash!
    end
  end

  describe '.sos!' do
    it 'proxies to the LED' do
      led = instance_double 'Beacon::Led'
      expect(led).to receive(:blink).with(times: 3)
      expect(led).to receive(:blink).with(times: 3, duration: 0.5)
      expect(led).to receive(:blink).with(times: 3)
      allow(Beacon::Led).to receive(:new).and_return led
      described_class.sos!
    end
  end
end
