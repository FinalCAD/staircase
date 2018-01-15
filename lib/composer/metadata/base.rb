# Public:
# Recalculate the value accordling to the new dimensions
#
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
      # position  - Point - The current position on the matrix
      # keys      - Array - The pair of keys to look into the metadata
      #
      #
      # This method modifies the metadata.
      #
      # Examples
      #
      #   update!(position: #<Composer::Lip::Point:0x007fce0e30ba90 @x=8.0, @y=40.0>, keys: [ :Polyline, :Coordinates ])
      #   # => nil
      #
      def update!(position:, keys:)
        initial_value = metadata.dig(*keys)
        return unless initial_value

        new_value = _update!(initial_value, position, keys)

        update_metadata(keys: keys, value: new_value)
        nil
      end

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
