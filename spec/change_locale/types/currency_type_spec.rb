require 'spec_helper'

describe Types::CurrencyType do

  it do
    expect(described_class.new(:foo)).to_not be_valid
    expect(described_class.new('10.271,29')).to be_valid
    expect(described_class.new('10.271,29').to_cell).to eql('€10,271.29')
    expect(described_class.new('-3.947,89').to_cell).to eql('-€3,947.89')
    expect(described_class.new('-46,77').to_cell).to eql('-€46.77')
    expect(described_class.new('46,77').to_cell).to eql('€46.77')
  end
end
