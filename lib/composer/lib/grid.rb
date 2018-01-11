module Composer
  module Lib
    class Grid

      attr_reader :number_of_images, :columns, :rows

      def initialize(number_of_images)
        @number_of_images = number_of_images
        @columns = Math.sqrt(number_of_images).ceil
        @rows    = Math.sqrt(number_of_images).round

        @cursor = Cursor.new(columns: columns, rows: rows)
      end

      def move
        @cursor.move
      end

      def reset
        @cursor = Cursor.new(columns: columns, rows: rows)
      end
    end
  end
end
