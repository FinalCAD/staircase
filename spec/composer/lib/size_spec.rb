require 'spec_helper'

describe Composer::Lib::Size do
  [
    {
      image:  { size: { width: 2120.0, height: 1620.0 }},
      grid:   { columns: 2, rows: 2 },
      resize: { width: 1000.0, height: 750.0 }
    },
    {
      image:  { size: { width: 2120.0, height: 1620.0 }},
      grid:   { columns: 3, rows: 2 },
      resize: { width: 653.33, height: 750.0 }
    },
    {
      image:  { size: { width: 2200.0, height: 1700.0 }},
      grid:   { columns: 4, rows: 4 },
      resize: { width: 500.00, height: 375.0 }
    }
  ].each do |info|
    context do
      let(:grid) { instance_double('Composer::Lib::Grid') }

      let(:width)   { info.dig(:resize, :width) }
      let(:height)  { info.dig(:resize, :height) }

      let(:columns) { info.dig(:grid, :columns) }
      let(:rows)    { info.dig(:grid, :rows) }

      let(:original_image_dimension) do
        Composer::Lib::Dimension.new(height: info.dig(:image, :size, :height), width: info.dig(:image, :size, :width))
      end

      before do
        expect(grid).to receive(:columns).at_least(:once) { columns }
        expect(grid).to receive(:rows).at_least(:once)    { rows }
      end

      subject do
        described_class.new(grid: grid, dimension: original_image_dimension).call
      end

      it do
        expect(subject.target_dimension.width).to  eql(width)
        expect(subject.target_dimension.height).to eql(height)
      end
    end
  end
end
