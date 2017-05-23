require 'spec_helper'

RSpec.describe Beacon::Log do
  describe '#debug' do
    describe 'no logger' do
      it 'does not fail' do
        Beacon.config.logger = nil
        described_class.debug { 'wow' }
      end
    end

    describe 'default logger' do
      it 'writes a debug message' do
        message = "debugging#{Time.now.to_i}"
        described_class.debug { message }
        log_file = Pathname.new('log/test.log')
        expect(log_file.read).to include "DEBUG -- #{message}"
      end
    end
  end

  describe '#info' do
    describe 'no logger' do
      it 'does not fail' do
        Beacon.config.logger = nil
        described_class.info { 'wow' }
      end
    end

    describe 'default logger' do
      it 'writes an informational message' do
        message = "information#{Time.now.to_i}"
        described_class.info { message }
        log_file = Pathname.new('log/test.log')
        expect(log_file.read).to include "INFO -- #{message}"
      end
    end
  end

  describe '#warn' do
    describe 'no logger' do
      it 'does not fail' do
        Beacon.config.logger = nil
        described_class.warn { 'wow' }
      end
    end

    describe 'default logger' do
      it 'writes an warning message' do
        message = "warning#{Time.now.to_i}"
        described_class.warn { message }
        log_file = Pathname.new('log/test.log')
        expect(log_file.read).to include "WARN -- #{message}"
      end
    end
  end

  describe '#error' do
    describe 'no logger' do
      it 'does not fail' do
        Beacon.config.logger = nil
        described_class.error { 'wow' }
      end
    end

    describe 'default logger' do
      it 'writes an error message' do
        message = "error#{Time.now.to_i}"
        described_class.error { message }
        log_file = Pathname.new('log/test.log')
        expect(log_file.read).to include "ERROR -- #{message}"
      end
    end
  end
end
