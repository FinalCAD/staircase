require 'spec_helper'

describe Composer::Lib::Size do
  let(:marge) { 40.0 }

  [
    {
      image:  { size: { width: 2109.0, height: 1818.0 }},
      number_of_images: 4,
      resize: { width: 984.9, height: 849.0 }
    },
    {
      image:  { size: { width: 2109.0, height: 1818.0 }},
      number_of_images: 6,
      resize: { width: 984.9, height: 849.0 }
    },
    {
      image:  { size: { width: 2109.0, height: 1818.0 }},
      number_of_images: 7,
      resize: { width: 641.13, height: 552.67 }
    },
    {
      image:  { size: { width: 2109.0, height: 1818.0 }},
      number_of_images: 8,
      resize: { width: 641.13, height: 552.67 }
    },
    {
      image:  { size: { width: 2109.0, height: 1818.0 }},
      number_of_images: 9,
      resize: { width: 641.13, height: 552.67 }
    },
    {
      image:  { size: { width: 2109.0, height: 1818.0 }},
      number_of_images: 24,
      resize: { width: 366.12, height: 315.6 }
    },
    {
      image:  { size: { width: 2109.0, height: 1818.0 }},
      number_of_images: 5,
      resize: { width: 984.9, height: 849.0 }
    }
  ].each do |info|
    context do
      let(:grid) { Composer::Lib::Grid.new(info.dig(:number_of_images)) }

      let(:width)   { info.dig(:resize, :width) }
      let(:height)  { info.dig(:resize, :height) }

      let(:layout_dimension) do
        Composer::Lib::Dimension.new(height: info.dig(:image, :size, :height), width: info.dig(:image, :size, :width))
      end

      subject { described_class.new(grid: grid, layout_dimension: layout_dimension, marge: marge).call }

      it do
        expect(subject.image_dimension.width).to  eql(width)
        expect(subject.image_dimension.height).to eql(height)
        expect(layout_dimension.ratio).to  eql(subject.image_dimension.ratio)
        expect(subject.to_s).to eql("#{width}x#{height}")
      end
    end
  end
end
