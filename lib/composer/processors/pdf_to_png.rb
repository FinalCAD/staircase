module Composer
  module Processors
    class PdfToPng

      def process(staircase_model)
        staircase_model.sectors.each do |_, sector_model|
          copy(convert(sector_model.path(:pdf)), sector_model.path(:png))
          sector_model.zones.each do |_, zone_model|
            copy(convert(zone_model.path(:pdf)), zone_model.path(:png))
          end
        end
      end

      private

      def convert(pdf_file)
        return unless pdf_file.exists?
        Converter::PdfToImage.new(pdf_file, convert_options: image_convert_options).process
      end

      def copy(from, to)
        FileUtils.cp(from.path, to.path)
      end

      def image_convert_options
        IMAGE_CONVERT_OPTIONS
      end

      IMAGE_CONVERT_OPTIONS = [
          '-geometry 2109x1818',
          '-colors 64',
          '-depth 8',
          '-density 450',
          '+dither'
      ].freeze
      private_constant :IMAGE_CONVERT_OPTIONS

    end
  end
end
