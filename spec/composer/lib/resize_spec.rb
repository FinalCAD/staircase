require 'spec_helper'

describe Composer::Lib::Resize do
  [
    {
      square: { width: 2120.0, height: 1620.0, columns: 2, rows: 2 },
      result: { width: 1000.0, height: 750.0 }
    },{
      square: { width: 2120.0, height: 1620.0, columns: 3, rows: 2 },
      result: { width: 653.33, height: 750.0 }
    },{
      square: { width: 2200.0, height: 1700.0, columns: 4, rows: 4 },
      result: { width: 500.00, height: 375.0 }
    }
  ].each do |info|
    context do
      let(:grid) { instance_double('Composer::Lib::Grid') }

      let(:width)  { info[:result][:width] }
      let(:height) { info[:result][:height] }

      before do
        expect(grid).to receive(:columns).at_least(:once).and_return(info[:square][:columns])
        expect(grid).to receive(:rows).at_least(:once).and_return(info[:square][:rows])
      end

      it do
        resize = described_class.new(grid, info[:square][:height], info[:square][:width])
        expect(resize.width).to  eql(width)
        expect(resize.height).to eql(height)
      end
    end
  end
end
