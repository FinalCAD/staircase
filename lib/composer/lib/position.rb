# Public: Give the coordinate X and Y where the image should be placed depends of where we are on the Matrix
#
# Need to know the dimension of the images and their marges.
#
module Composer
  module Lib
    class Position

      def initialize(marge: Dimension.new(height: 40.0, width: 40.0), dimension:, footer: 0.0)
        @marge     = marge
        @dimension = dimension
        @footer    = footer
      end

      def coordinate(column:, row:)
        Point.new(y: position_y(row), x: position_x(column))
      end

      private

      attr_reader :marge, :dimension, :footer

      def position_y(row)
        ((row + 1) * marge.y + row * dimension.height) + (row * footer)
      end

      def position_x(column)
        (column + 1) * marge.x + column * dimension.width
      end

    end
  end
end
