require 'spec_helper'

RSpec.describe Beacon::Led, :awake do
  describe '#path' do
    it 'is the Raspberry Pi LED device as Pathname' do
      led = described_class.new
      expect(led.send(:path)).to eq Pathname.new('/sys/class/leds/led0/brightness')
    end
  end

  describe '#blink' do
    context 'default arguments' do
      it 'blinks once' do
        led = described_class.new
        path = instance_double Pathname
        allow(led).to receive(:path).and_return path
        expect(path).to receive(:write).with 1
        expect(path).to receive(:write).exactly(2).times.with 0
        expect(Beacon::Sleep).to receive(:call).exactly(2).times.with 0.1
        led.blink
      end
    end

    context 'custom arguments' do
      it 'respects custom timing' do
        led = described_class.new
        path = instance_double Pathname
        allow(led).to receive(:path).and_return path
        expect(path).to receive(:write).exactly(2).with 1
        expect(path).to receive(:write).exactly(3).times.with 0
        expect(Beacon::Sleep).to receive(:call).exactly(2).times.with 0.3
        expect(Beacon::Sleep).to receive(:call).exactly(2).times.with 0.7
        led.blink times: 2, duration: 0.3, pause: 0.7
      end
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

  describe '#off!' do
    context 'path does not exist' do
      it 'does not raise an exception' do
        led = described_class.new
        allow(led).to receive(:path).and_return Pathname.new('/tmp/no/way')
        expect(led.send(:off!)).to be nil
      end
    end

    context 'path exists' do
      it 'writes 0 to the file' do
        led = described_class.new
        Tempfile.create('device') do |tempfile|
          allow(led).to receive(:path).and_return Pathname.new(tempfile.path)
          led.send(:off!)
          expect(tempfile.read).to eq '0'
        end
      end
    end
  end

end
