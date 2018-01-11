require 'spec_helper'

describe Composer::Lib::TextPosition do
  let(:image_dimension)  { Composer::Lib::Dimension.new(height: 849.0,  width: 985.0)  }
  let(:layout_dimension) { Composer::Lib::Dimension.new(height: 1818.0, width: 2109.0) }
  let(:pointsize)        { 32.0 }

  [
    {
      position:   { x: 40.0, y: 8.0 },
      coordinate: { x: -522.0, y: -36.0 }
    },
    {
      position: { x: 1065.0, y: 8.0 },
      coordinate: { x: 503.0, y: -36.0 }
    },
    {
      position: { x: 40.0, y: 897.0 },
      coordinate: { x: -522.0, y: 853.0 }
    },
    {
      position: { x: 1065.0, y: 897.0 },
      coordinate: { x: 503.0, y: 853.0 }
    }
  ].each do |info|
    context do
      let(:position) { Composer::Lib::Point.new(y: info.dig(:position, :y), x: info.dig(:position, :x)) }

      subject { described_class.new(pointsize: pointsize, image_dimension: image_dimension, layout_dimension: layout_dimension) }

      it do
        coordinate = subject.coordinate(position)

        expect(coordinate.x).to eql(info.dig(:coordinate, :x))
        expect(coordinate.y).to eql(info.dig(:coordinate, :y))
      end
    end
  end
end
