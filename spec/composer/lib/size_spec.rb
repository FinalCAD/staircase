require 'spec_helper'

describe Composer::Lib::Size do
  [
    {
      image:  { size: { width: 2120.0, height: 1620.0 }},
      grid:   { columns: 2, rows: 2 },
      resize: { width: 981.48, height: 750.0 }
    },
    {
      image:  { size: { width: 2120.0, height: 1620.0 }},
      grid:   { columns: 3, rows: 2 },
      resize: { width: 981.48, height: 750.0 }
    },
    {
      image:  { size: { width: 2200.0, height: 1700.0 }},
      grid:   { columns: 4, rows: 4 },
      resize: { width: 485.29, height: 375.0 }
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

      before { expect(grid).to receive(:rows).at_least(:once) { rows } }

      subject { described_class.new(grid: grid, dimension: original_image_dimension).call }

      it do
        expect(subject.target_dimension.width).to  eql(width)
        expect(subject.target_dimension.height).to eql(height)
        expect(original_image_dimension.ratio).to  eql(subject.target_dimension.ratio)
      end
    end
  end
end
