module Composer
  module Processors
    class PdfToPng < Base

      def process(staircase_model)
        staircase_model.sectors.each do |_, sector_model|
          copy(convert(sector_model.full_path(:pdf)), sector_model.full_path(:png))
          sector_model.zones.each do |_, zone_model|
            copy(convert(zone_model.full_path(:pdf)), zone_model.full_path(:png))
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
