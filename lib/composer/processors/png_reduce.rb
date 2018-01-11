module Composer
  module Processors
    class PngReduce < Base

      def process(staircase_model)
        set_resize(staircase_model.number_of_images)

        staircase_model.sectors.each do |_, sector_model|
          copy(convert(sector_model.full_path(:png)), sector_model.full_path(:png))
        end

        nil
      end

      private

      def set_resize(number_of_images)
        grid = Lib::Grid.new(number_of_images)
        size = Lib::Size.new(grid: grid, layout_dimension: Lib::Dimension.new(height: 2109.0, width: 1818.0)).call
        set_convert_options(size)
      end

      def set_convert_options(size)
        @options = [ "-resize #{size}" ]
      end

      def converter
        @converter ||= 'Composer::Converter::SectorPngReduce'
      end

      def convert_options
        @options
      end
    end
  end
end
