# Public: Give the coordinate X and Y where the blueprint of the sector should be placed depends of where we are on the Matrix
#
# Need to know the image_dimension of the images and their marges.
#
module Composer
  module Lib
    class TextPosition

      attr_reader :pointsize

      def initialize(pointsize:, image_dimension:, layout_dimension:)
        @pointsize        = pointsize
        @image_dimension  = image_dimension
        @layout_dimension = layout_dimension
      end

      def coordinate(position)
        Point.new(y: position_y(position.y), x: position_x(position.x))
      end

      private

      attr_reader :image_dimension, :layout_dimension

      def position_y(position)
        position + image_dimension.height + pointsize / 2 - layout_dimension.height / 2
      end

      def position_x(position)
        position - layout_dimension.width / 2 + image_dimension.width / 2
      end

    end
  end
end
