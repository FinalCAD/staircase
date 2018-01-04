require 'spec_helper'

describe Composer::Lib::Resize do
  let(:grid)   { instance_double('Composer::Lib::Grid') }
  let(:width)  { 2120.0 }
  let(:height) { 1620.0 }

  before do
    expect(grid).to receive(:columns).at_least(:once).and_return(2)
    expect(grid).to receive(:rows).at_least(:once).and_return(2)
  end

  it do
    resize = described_class.new(grid, height, width)
    expect(resize.width).to eql(1000.0)
    expect(resize.height).to eql(750.0)
  end
end
