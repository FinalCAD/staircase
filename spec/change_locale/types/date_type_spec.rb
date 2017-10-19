require 'spec_helper'

describe Types::DateType do

  it do
    expect(described_class.new(:foo)).to_not be_valid
    expect(described_class.new('29/09/2017')).to be_valid
    expect(described_class.new('09/29/2017')).to_not be_valid
    expect(described_class.new('29/09/2017').to_cell).to eql('09/29/2017')
  end
end
