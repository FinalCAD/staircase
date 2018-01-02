module Composer
  module Processors
    class ComposeGrid

      def initialize(context={})
        @export_path = context.fetch(:export_path)
      end

      def process(staircase_model)
        staircase_model.sectors.each do |_, sector_model|
          copy(convert(sector_model.source_path(:pdf)), sector_model.source_path(:png))
          sector_model.zones.each do |_, zone_model|
            copy(convert(zone_model.source_path(:pdf)), zone_model.source_path(:png))
          end
        end
      end

      private

      def convert(pdf_file)
        return unless pdf_file.exists?
        Converter::PdfToImage.new(pdf_file, convert_options: image_convert_options).process
      end

      def image_convert_options
        IMAGE_CONVERT_OPTIONS
      end

      IMAGE_CONVERT_OPTIONS = [
        '-size 2109.0x1818.0',
        'xc:#F4F5F6'
      ].freeze
      private_constant :IMAGE_CONVERT_OPTIONS

    end
  end
end
