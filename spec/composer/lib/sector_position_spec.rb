require 'spec_helper'

describe Composer::Lib::SectorPosition do
  let(:marge)  { Composer::Lib::Dimension.new(height: 8.0, width: 40.0) }
  let(:footer) { 32.0 }

  [
    {
      matrix:   { cell: { column: 0, row: 0 }},
      image:    { size: { width: 2120.0, height: 1620.0 }},
      position: { x: 40.0, y: 8.0 }
    },
    {
      matrix:   { cell: { column: 1, row: 0 }},
      image:    { size: { width: 985.0, height: 849.0 }},
      position: { x: 1065.0, y: 8.0 }
    },
    {
      matrix:   { cell: { column: 0, row: 1 }},
      image:    { size: { width: 985.0, height: 849.0 }},
      position: { x: 40.0, y: 897.0 }
    },
    {
      matrix:   { cell: { column: 1, row: 1 }},
      image:    { size: { width: 985.0, height: 849.0 }},
      position: { x: 1065.0, y: 897.0 }
    }
  ].each do |info|
    context do
      let(:width)   { info.dig(:image, :size, :width) }
      let(:height)  { info.dig(:image, :size, :height) }
      let(:column)  { info.dig(:matrix, :cell, :column) }
      let(:row)     { info.dig(:matrix, :cell, :row) }

      let(:dimension) { Composer::Lib::Dimension.new(height: height, width: width) }

      subject { described_class.new(dimension: dimension, footer: footer, marge: marge) }

      it do
        position = subject.coordinate(column: column, row: row)

        expect(marge.y).to eql(8.0)
        expect(marge.x).to eql(40.0)

        expect(position.x).to eql(info.dig(:position, :x))
        expect(position.y).to eql(info.dig(:position, :y))

        expect(position.to_a).to eql([info.dig(:position, :x), info.dig(:position, :y)])
      end
    end
  end
end
