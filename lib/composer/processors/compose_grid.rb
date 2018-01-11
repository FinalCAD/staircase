module Composer
  module Processors
    class ComposeGrid < Base

      def process(staircase_model)
        number_of_images = staircase_model.number_of_images
        marge            = Lib::Dimension.new(height: 8.0, width: 40.0)
        grid             = Lib::Grid.new(number_of_images)
        size             = Lib::Size.new(grid: grid, layout_dimension: layout_dimension, marge: 40.0).call
        sector_position  = Lib::SectorPosition.new(dimension: size.image_dimension, marge: marge, footer: 32.0)
        text_position    = Lib::TextPosition.new(image_dimension: size.image_dimension, layout_dimension: layout_dimension)

        staircase_model.sectors.each do |_, sector_model|
          cmd = []

          cell = grid.move
          geometry = sector_position.coordinate(column: cell.column.to_i, row: cell.row.to_i)

          file_to_compose_path = Lib::SafePath.new((sector_model.full_path(:png).path)).path

          cmd << "composite -geometry #{size}#{geometry} #{file_to_compose_path}"

          cmd << staircase_path(staircase_model).path
          cmd << staircase_path(staircase_model).path

          run_command(cmd.join(' '))

          a = [
            'convert',
            staircase_path(staircase_model).path,
            '-fill "#071D49"',
            "-pointsize #{text_position.pointsize}",
            '-gravity Center',
            "-annotate #{text_position.coordinate(geometry)}",
            "\"#{sector_model.name}\"",
            staircase_path(staircase_model).path
          ]

          puts("=> #{a.join(' ')}")

          run_command(a.join(' '))
        end

        nil
      end

      private

      def layout_dimension
        @layout_dimension ||= Lib::Dimension.new(width: 2109.0, height: 1818.0)
      end

      def staircase_path(model)
        Lib::SafePath.new([ exporter.export_path, "Sectors", "#{model.name}.png" ].join(File::SEPARATOR))
      end

      def run_command(cmd)
        system(cmd)
      end
    end
  end
end
