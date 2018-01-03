module Composer
  module Processors
    class PngReduce < Base

      def process(staircase_model)
        staircase_model.sectors.each do |_, sector_model|
          copy(convert(sector_model.full_path(:png)), sector_model.full_path(:png))
        end

        nil
      end

      private

      def converter
        @converter ||= 'Composer::Converter::SectorPngReduce'
      end

      def convert_options
        IMAGE_REDUCE_OPTIONS
      end

      IMAGE_REDUCE_OPTIONS = [
        '-resize 1054.5x909.0'
      ].freeze
      private_constant :IMAGE_REDUCE_OPTIONS
    end
  end
end
