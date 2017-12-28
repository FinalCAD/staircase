require 'spec_helper'

require 'ostruct'

describe Composer::Model do
  let(:path)     { 'spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors' }
  let(:options)  {{}}

  let(:instance) do
    described_class.new(path, options)
  end

  it do
    expect(instance.class.name).to eql('Composer::Model')
    expect(instance.staircase_name).to eql('Staircase Name 1')
  end
end
