module Composer
  module Metadata
    module Base
      extend ActiveSupport::Concern

      def initialize(metadata:, layout_dimension:, image_dimension:)
        @layout_dimension = layout_dimension
        @image_dimension  = image_dimension
        @metadata         = metadata.with_indifferent_access
      end

      included do
        attr_reader :metadata

        private

        attr_reader :layout_dimension, :image_dimension
      end

      # Public: Duplicate some text an arbitrary number of times.
      #
      # text  - The String to be duplicated.
      # count - The Integer number of times to duplicate the text.
      #
      # Examples
      #
      #   multiplex('Tom', 4)
      #   # => 'TomTomTomTom'
      #
      # def update!(position:, keys:)
      # end

      private

      def width_position(initial_value:, position:)
        position.x / layout_dimension.width + image_dimension.width * initial_value / layout_dimension.width
      end

      def height_position(initial_value:, position:)
        position.y / layout_dimension.height + image_dimension.width * initial_value / layout_dimension.height
      end

      def update_metadata(keys:, value:)
        *key, last = keys
        key.inject(metadata, :fetch)[last] = value
      end

    end
  end
end
