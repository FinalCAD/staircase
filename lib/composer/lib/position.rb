# Public: Give the coordinate X and Y where the image should be placed depends of where we are on the Matrix
#
# Need to know the dimension of the images and their marges.
#
module Composer
  module Lib
    class Position

      def initialize(marge: Dimension.new(height: 40.0, width: 40.0), dimension:)
        @marge, @dimension = marge, dimension
      end

      def point(column, row)
        Point.new(y: column_position(column), x: row_position(row))
      end

      private

      attr_reader :marge, :dimension

      def column_position(column)
        (column + 1) * marge.y + column * dimension.width
      end

      def row_position(row)
        (row + 1) * marge.x + row * dimension.height
      end

    end
  end
end
