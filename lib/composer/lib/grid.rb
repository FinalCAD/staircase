module Composer
  module Lib
    class Grid

      attr_reader :number_of_images, :columns, :rows

      def initialize(number_of_images)
        @number_of_images = number_of_images
        @columns = Math.sqrt(number_of_images).ceil
        @rows    = Math.sqrt(number_of_images).round

        @column_cursor = Cursor.new(columns)
        @row_cursor    = Cursor.new(rows)
      end

      def move
        Point.new(y: next_column, x: next_row)
      end

      private

      attr_reader :column_cursor, :row_cursor

      def next_column
        column_cursor.next_position { change_row! }
      end

      def next_row
        reset_row! if column_changed?
        @current_row ||= row_cursor.next_position
      end

      def column_changed?
        column_cursor.current_position == columns
      end

      def reset_row!
        @row_cursor = Cursor.new(rows)
      end

      def change_row!
        @current_row = nil
      end

      class Cursor
        def initialize(size)
          @size = size
          @position = -1
        end

        def next_position
          reset if reached_bound?
          if block_given?
            yield if reinitiated?
          end
          @position += 1
        end

        def current_position
          @position
        end

        private

        def reset
          @position = -1
        end

        def reinitiated?
          @position == -1
        end

        attr_reader :size

        def reached_bound?
          (@position + 1) >= size
        end
      end

    end
  end
end
