require 'spec_helper'

describe Beacon::Leds do
  describe '.blink!' do
    describe 'path is unaccessible' do
      it 'does not cause an exception' do
        Beacon::Leds.blink!(1)
      end
    end
  end

  describe '.stare!' do
    describe 'path is unaccessible' do
      it 'does not cause an exception' do
        Beacon::Leds.stare!
      end
    end
  end

  describe '.flash!' do
    describe 'path is unaccessible' do
      it 'does not cause an exception' do
        Beacon::Leds.flash!
      end
    end
  end

  describe '.sos!' do
    describe 'path is unaccessible' do
      it 'does not cause an exception' do
        Beacon::Leds.sos!
      end
    end
  end
end
