module Composer
  module Processors
    class Base

      attr_reader :export_path

      def initialize(context)
        @export_path      = context[:export_path]
        @layout_dimension = Lib::Dimension.new(width: Composer.configuration.layout[:dimension][:width], height: Composer.configuration.layout[:dimension][:height])
        @marge            = Lib::Dimension.new(height: Composer.configuration.layout[:marge][:height], width: Composer.configuration.layout[:marge][:width])
      end

      def process(staircase_model)
        @number_of_images = staircase_model.number_of_images
        @grid             = Lib::Grid.new(number_of_images)
        @size             = Lib::Size.new(grid: grid, layout_dimension: layout_dimension, marge: Composer.configuration.layout[:marge][:width]).call
        @sector_position  = Lib::SectorPosition.new(dimension: size.image_dimension, marge: marge, footer: Composer.configuration.layout[:footer])
        @text_position    = Lib::TextPosition.new(pointsize: Composer.configuration.layout[:pointsize], image_dimension: size.image_dimension, layout_dimension: layout_dimension)
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

      def write(name, content)
        file = Tempfile.new(name)
        file.write(content)
        file.rewind
        file
      end

      private

      def convert(file)
        return unless File.exists?(file.path.to_s)
        converter.constantize.new(file, convert_options: convert_options).process
      end

      def copy(from, to)
        FileUtils.mkdir_p(File.dirname(to.path.to_s))
        FileUtils.cp(from.path.to_s, to.path.to_s)
        from.close if from.respond_to?(:close)
        from.unlink if from.respond_to?(:unlink)
      end

    end
  end
end
