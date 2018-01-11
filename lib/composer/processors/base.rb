module Composer
  module Processors
    class Base

      attr_reader :export_path

      def initialize(context)
        @export_path = context[:export_path]
      end

      def process(staircase_model)
        @number_of_images = staircase_model.number_of_images
        @marge            = Lib::Dimension.new(height: 8.0, width: 40.0)
        @grid             = Lib::Grid.new(number_of_images)
        @layout_dimension = Lib::Dimension.new(width: 2109.0, height: 1818.0)
        @size             = Lib::Size.new(grid: grid, layout_dimension: layout_dimension, marge: 40.0).call
        @sector_position  = Lib::SectorPosition.new(dimension: size.image_dimension, marge: marge, footer: 32.0)
        @text_position    = Lib::TextPosition.new(image_dimension: size.image_dimension, layout_dimension: layout_dimension)
      end

      protected

      attr_reader :number_of_images, :marge, :grid, :size, :sector_position, :text_position, :layout_dimension

      def run_command(cmd)
        puts("#{self.class.name} => #{cmd}")
        system(cmd)
      end

      def layout_path(model)
        Lib::SafePath.new([ export_path, "Sectors", "#{model.name}.png" ].join(File::SEPARATOR))
      end

      private

      def convert(file)
        return unless File.exists?(file.path.to_s)
        converter.constantize.new(file, convert_options: convert_options).process
      end

      def copy(from, to)
        FileUtils.mkdir_p(File.dirname(to.path.to_s))
        FileUtils.cp(from.path.to_s, to.path.to_s)
      end

    end
  end
end
