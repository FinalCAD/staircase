require 'spec_helper'

require 'ostruct'

describe Composer::Model do
  let(:path)     { 'spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors' }
  let(:options)  {{}}

  let(:instance) { described_class.new(path, options) }

  it do
    expect(instance.exploded_path).to eql(['spec', 'fixtures', 'archive', 'input', 'Staircases', 'Staircase Name 1', 'Sectors'])
  end
end
