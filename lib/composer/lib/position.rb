module Composer
  module Lib
    class Position

      def initialize(resize)
        @resize = resize
      end

      def point(column, row)
        [
          column_position(column),
          row_position(row)
        ]
      end

      private

      def column_position(column)
        marge = (column + 1) * resize.marge
        image_width = column * resize.width
        marge + image_width
      end

      def row_position(row)
        marge = (row + 1) * resize.marge
        image_height = row * resize.height
        marge + image_height
      end

      attr_reader :resize

    end
  end
end
