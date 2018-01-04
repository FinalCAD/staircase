module Composer
  module Lib
    class Grid

      attr_reader :columns, :rows

      def initialize(number_of_images)
        @columns = Math.sqrt(number_of_images).ceil
        @rows = Math.sqrt(number_of_images).round
      end

    end
  end
end
