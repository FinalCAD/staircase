require "spec_helper"

describe CsvConvert::Pro::RowConvertor do
  let(:input)  { [ "14/09/2017", nil,"Transferencia emitida WOHABY", "Wohaby Factura 2017-0298 Extra Hours August", "-8,25", "3.562,99", "" ] }
  let(:output) { [ "09/14/2017", "Transferencia emitida WOHABY", "Wohaby Factura 2017-0298 Extra Hours August", nil, "-€8.25", nil, nil, "€3,562.99" ] }

  it do
    expect(described_class.new(input).to_row).to eql(output)
  end
end
