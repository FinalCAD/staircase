module Composer
  module Lib
    class Point

      def initialize(y:, x:)
        @y, @x = y, x
      end

      def y
        @y.to_f.round(1)
      end
      alias_method :row, :y

      def x
        @x.to_f.round(1)
      end
      alias_method :column, :x

      def to_a
        [ x, y ]
      end

      # Public: Returns the formatted instruction for imagemagick
      #
      # http://www.imagemagick.org/Usage/layers/#composition
      # composite -geometry 40x40+5+10  balloon.gif comp_resize.gif comp_resize.gif
      # <width>x<height>+<width + marge x * munber of columns>+<height + marge y * munber of rows>
      #
      # +<marge x>+<marge y>               - +<width + marge x * 2>+<marge y>
      # +<marge x>+<height + marge y * 2>  - +<width + marge x * 2>+<height + marge y * 2>
      #
      # Examples
      #
      #   to_s
      #   # => '+40.0+8.0'
      #
      def to_s
        to_a.map { |entry| "+#{entry}" }.join
      end

    end
  end
end
