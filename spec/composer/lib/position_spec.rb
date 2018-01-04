require 'spec_helper'

describe Composer::Lib::Position do
  [
    {
      point:  { column: 0, row: 0 },
      size:   { width: 2120.0, height: 1620.0, marge: 40.0 },
      result: [ 40.0, 40.0 ]
    },{
      point:  { column: 1, row: 0 },
      size:   { width: 2120.0, height: 1620.0, marge: 40.0 },
      result: [ 2200.0, 40.0 ]
    },{
      point:  { column: 1, row: 1 },
      size:   { width: 2120.0, height: 1620.0, marge: 40.0 },
      result: [ 2200.0, 1700.0 ]
    }
  ].each do |info|
    context do
      let(:resize) { instance_double('Composer::Lib::Resize') }

      let(:width)  { info[:result][:width] }
      let(:height) { info[:result][:height] }

      before do
        expect(resize).to receive(:height).at_least(:once).and_return(info[:size][:height])
        expect(resize).to receive(:width).at_least(:once).and_return(info[:size][:width])
        expect(resize).to receive(:marge).at_least(:once).and_return(info[:size][:marge])
      end

      it do
        position = described_class.new(resize)
        expect(position.point(info[:point][:column], info[:point][:row])).to eql(info[:result])
      end
    end
  end
end
