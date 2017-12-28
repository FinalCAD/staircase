module Composer
  module Converter
    class Base
      attr_reader :input, :options

      def initialize(input, options={})
        @input, @options = input, options
      end

      def process
        raise "implement this method"
      end

      def path
        input.try(:path)
      end
    end
  end
end
