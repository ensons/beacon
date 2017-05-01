require 'spec_helper'

RSpec.describe Beacon::Log do
  describe '#debug' do
    describe 'no logger' do
      it 'does not fail' do
        Beacon.config.logger = nil
        Beacon::Log.debug { 'wow' }
      end
    end

    describe 'default logger' do
      it 'writes a debug message' do
        message = "debugging#{Time.now.to_i}"
        Beacon::Log.debug { message }
        log_file = Pathname.new('log/test.log')
        expect(log_file.read).to include "DEBUG -- #{message}"
      end
    end
  end

  describe '#info' do
    describe 'no logger' do
      it 'does not fail' do
        Beacon.config.logger = nil
        Beacon::Log.info { 'wow' }
      end
    end

    describe 'default logger' do
      it 'writes an informational message' do
        message = "information#{Time.now.to_i}"
        Beacon::Log.info { message }
        log_file = Pathname.new('log/test.log')
        expect(log_file.read).to include "INFO -- #{message}"
      end
    end
  end

  describe '#warn' do
    describe 'no logger' do
      it 'does not fail' do
        Beacon.config.logger = nil
        Beacon::Log.warn { 'wow' }
      end
    end

    describe 'default logger' do
      it 'writes an warning message' do
        message = "warning#{Time.now.to_i}"
        Beacon::Log.warn { message }
        log_file = Pathname.new('log/test.log')
        expect(log_file.read).to include "WARN -- #{message}"
      end
    end
  end

  describe '#error' do
    describe 'no logger' do
      it 'does not fail' do
        Beacon.config.logger = nil
        Beacon::Log.error { 'wow' }
      end
    end

    describe 'default logger' do
      it 'writes an error message' do
        message = "error#{Time.now.to_i}"
        Beacon::Log.error { message }
        log_file = Pathname.new('log/test.log')
        expect(log_file.read).to include "ERROR -- #{message}"
      end
    end
  end
end
