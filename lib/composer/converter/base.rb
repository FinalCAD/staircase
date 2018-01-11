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


    end
  end
end
