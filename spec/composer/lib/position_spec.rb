require 'spec_helper'

describe Composer::Lib::Position do
  [
    {
      point:  { column: 0, row: 0 },
      size:   { width: 2120.0, height: 1620.0 },
      result: [ 40.0, 40.0 ]
    },
    {
      point:  { column: 1, row: 0 },
      size:   { width: 2120.0, height: 1620.0 },
      result: [ 2200.0, 40.0 ]
    },
    {
      point:  { column: 1, row: 1 },
      size:   { width: 2120.0, height: 1620.0 },
      result: [ 2200.0, 1700.0 ]
    }
  ].each do |info|
    context do
      let(:width)  { info.dig(:size, :width) }
      let(:height) { info.dig(:size, :height) }

      let(:column)  { info.dig(:point, :column) }
      let(:row)     { info.dig(:point, :row) }

      let(:dimension) { Composer::Lib::Dimension.new(height: height, width: width) }

      subject { described_class.new(dimension: dimension) }

      it do
        expect(subject.point(column, row).to_a).to eql(info[:result])
      end
    end
  end
end
