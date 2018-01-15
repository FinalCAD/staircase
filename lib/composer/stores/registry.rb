require 'singleton'

module Composer
  module Stores
    class Registry
      include Singleton

      attr_reader :models

      def initialize
        reset!
      end

      def append_model(model)
        return unless model.name

        models[model.name] ||= model
      end

      def reset!
        @models = {}
      end

    end
  end
end
