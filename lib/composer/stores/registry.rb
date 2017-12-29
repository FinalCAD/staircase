require 'singleton'

module Composer
  module Stores
    class Registry
      include Singleton

      attr_reader :inputs, :outputs

      def initialize
        reset!
      end

      def append_input(model)
        return unless model.name

        inputs[model.name] ||= model
      end

      def append_output(model)
        return unless model.name

        outputs[model.name] ||= model
      end

      def reset!
        @inputs  = {}
        @outputs = {}
      end

    end
  end
end
