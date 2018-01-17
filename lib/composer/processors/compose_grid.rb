module Composer
  module Processors
    class ComposeGrid < Base

      def process(staircase_model)
        super

        staircase_model.sectors.each do |_, sector_model|
          cmd = []

          cell = grid.move
          position = sector_position.coordinate(column: cell.column.to_i, row: cell.row.to_i)

          file_to_compose_path = sector_model.full_path(:png).path.escaped

          cmd << "composite -geometry #{size}#{position} #{file_to_compose_path}"

          cmd << layout_path(staircase_model).path.escaped
          cmd << layout_path(staircase_model).path.escaped

          run_command(cmd.join(' '))
        end

        nil
      end

    end
  end
end
