require 'spec_helper'

RSpec.describe Beacon::Led, :awake do
  describe '#path' do
    it 'is the Raspberry Pi LED device as Pathname' do
      led = described_class.new
      expect(led.send(:path)).to eq Pathname.new('/sys/class/leds/led0/brightness')
    end
  end

  describe '#on!' do
    context 'path does not exist' do
      it 'does not raise an exception' do
        led = described_class.new
        allow(led).to receive(:path).and_return Pathname.new('/tmp/no/way')
        expect(led.send(:on!)).to be nil
      end
    end

    context 'path exists' do
      it 'writes 1 to the file' do
        led = described_class.new
        Tempfile.create('device') do |tempfile|
          allow(led).to receive(:path).and_return Pathname.new(tempfile.path)
          led.send(:on!)
          expect(tempfile.read).to eq '1'
        end
      end
    end
  end

end
