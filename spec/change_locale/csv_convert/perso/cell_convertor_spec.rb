require "spec_helper"

describe CsvConvert::Pro::CellConvertor do
  it do
    expect(described_class.new("14/09/2017", String).to_cell).to eql("14/09/2017")
    expect(described_class.new("14/09/2017", Types::DateType).to_cell).to eql("09/14/2017")
    expect(described_class.new("3.562,99", String).to_cell).to eql("3.562,99")
    expect(described_class.new("3.562,99", Types::CurrencyType).to_cell).to eql("€3,562.99")
  end
end
