# Public: Compute the size of the image to fit its space into a grid (Matrix compose of columns and rows)
# This space could have an x and y marge
#
# grid  - The matrix to fill
# dimension - The Dimension of the original image
#
# NOTE: It's been assumed all images have the same initial dimensions
# The library `Composer::Lib::Size` give access to the computed size the image should have to fit its space into the Grid through :target_dimension
# target_dimension its a `Composer::Lib::Dimension` object
#
module Composer
  module Lib
    class Size

      attr_reader :target_dimension

      def initialize(grid:, marge: Dimension.new(height: 40.0,width: 40.0), dimension:)
        @grid      = grid
        @dimension = dimension
        @marge     = marge
      end

      def call
        @target_dimension ||= Dimension.new(height: target_height, width: target_width)
        self
      end

      # Public: Returns the formatted instruction for imagemagick
      #
      # Examples
      #
      #   to_s
      #   # => '500.0x375.0'
      #
      def to_s
        "#{target_dimension.height}x#{target_dimension.width}"
      end

      private

      attr_reader :grid, :dimension, :marge

      def target_height
        @target_height ||= ((dimension.height - marge_row) / grid.rows).round(2)
      end

      def target_width
        (dimension.width / (dimension.height / target_height)).round(2)
      end

      # X Marge
      def marge_row
        marge.x * (grid.rows + 1)
      end
    end
  end
end
