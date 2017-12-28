require 'spec_helper'

describe Composer::Import::Dir do
  let(:source_path) { 'spec/fixtures/archive/input' }
  let(:instance)    { described_class.new(source_path) }

  describe '#next' do
    it { expect(instance.next).to be_a(Composer::Model) }
  end
end
