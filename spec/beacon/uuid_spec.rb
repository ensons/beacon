require 'spec_helper'

RSpec.describe Beacon::Uuid do
  describe '.call' do
    context 'file does not exist yet' do
      it 'writes a new UUID to the path' do
        Dir.mktmpdir do |tempdir|
          Beacon.config.uuid_path = Pathname.new(tempdir).join('uuid').to_s
          uuid = described_class.call
          regexp = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/
          expect(uuid).to match regexp
          expect(Pathname.new(Beacon.config.uuid_path).read).to eq uuid
        end
      end
    end

    context 'path already has a UUID' do
      it 'reads it from the path' do
        path = Pathname.new(Beacon.config.uuid_path)
        path.write 'i-am-a-uuid'
        expect(described_class.call).to eq 'i-am-a-uuid'
        expect(path.read).to eq 'i-am-a-uuid'
      end
    end

    context 'cannot write to path' do
      it 'is nil' do
        allow(Beacon.config).to receive(:uuid_path).and_raise Errno::EACCES::Errno
        expect(described_class.call).to be nil
      end
    end
  end
end
