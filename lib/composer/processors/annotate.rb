module Composer
  module Processors
    class Annotate < Base

      def process(staircase_model)
        super

        staircase_model.sectors.each do |_, sector_model|
          cell = grid.move
          image_position = sector_position.coordinate(column: cell.column.to_i, row: cell.row.to_i)

          cmd = [
            'convert',
            layout_path(staircase_model).path.escaped,
            '-fill "#071D49"',
            "-pointsize #{text_position.pointsize}",
            '-gravity Center',
            "-annotate #{text_position.coordinate(image_position)}",
            "\"#{sector_model.name}\"",
            layout_path(staircase_model).path.escaped
          ]

          run_command(cmd.join(' '))
        end

        nil
      end

    end
  end
end
