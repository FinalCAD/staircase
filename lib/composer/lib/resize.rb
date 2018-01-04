module Composer
  module Lib
    class Resize

      attr_reader :height, :width

      def initialize(grid, square_height, square_width)
        @grid = grid

        @square_height = square_height
        @square_width  = square_width

        @width  = ((square_width  - marge_column) / grid.columns).round(2)
        @height = ((square_height - marge_row) / grid.rows).round(2)
      end

      private

      attr_reader :grid

      def marge_column
        marge * (grid.columns + 1)
      end

      def marge_row
        marge * (grid.rows + 1)
      end

      def square_height
        @square_height.to_f
      end

      def square_width
        @square_width.to_f
      end

      def marge
        40.0
      end

    end
  end
end
