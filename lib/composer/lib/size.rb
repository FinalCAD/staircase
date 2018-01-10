# Public: Compute the size of the image to fit its space into a grid (Matrix compose of columns and rows)
# This space could have an x and y marge
#
# grid - The matrix to fill
# layout_dimension - The Dimension of the original image
#
# NOTE: It's been assumed all images have the same initial dimensions
# The library `Composer::Lib::Size` give access to the computed size the image should have to fit its space into the Grid through :image_dimension
# image_dimension its a `Composer::Lib::Dimension` object
#
module Composer
  module Lib
    class Size

      attr_reader :image_dimension

      def initialize(grid:, marge: 40.0, layout_dimension:)
        @grid             = grid
        @layout_dimension = layout_dimension
        @marge            = marge
      end

      def call
        @image_dimension ||= Dimension.new(height: target_height, width: target_width)
        self
      end

      # Public: Returns the formatted instruction for imagemagick
      #
      # http://www.imagemagick.org/Usage/layers/#composition
      # composite -geometry 40x40+5+10  balloon.gif comp_resize.gif comp_resize.gif
      # <width>x<height>+<width + marge x * munber of columns>+<height + marge y * munber of rows>
      #
      # Examples
      #
      #   to_s
      #   # => '500.0x375.0'
      #
      def to_s
        "#{image_dimension.width}x#{image_dimension.height}"
      end

      private

      attr_reader :grid, :layout_dimension, :marge

      def target_height
        @target_height ||= ((layout_dimension.height - marge_row) / grid.rows).round(2)
      end

      def target_width
        (layout_dimension.width / (layout_dimension.height / target_height)).round(2)
      end

      # Y Marge (Height)
      def marge_row
        marge * (grid.rows + 1)
      end
    end
  end
end
