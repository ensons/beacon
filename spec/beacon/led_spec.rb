require 'spec_helper'

RSpec.describe Beacon::Led do
  describe '#blink' do
    describe 'path is unaccessible' do
      it 'does not cause an exception' do
        Beacon::Led.new.blink
      end
    end
  end
end
