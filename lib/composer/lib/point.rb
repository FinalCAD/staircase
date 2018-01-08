module Composer
  module Lib
    class Point

      def initialize(y:, x:)
        @y, @x = y, x
      end

      def y
        @y.to_f
      end
      alias_method :column, :y

      def x
        @x.to_f
      end
      alias_method :row, :x

      def to_a
        [ y, x ]
      end

    end
  end
end
