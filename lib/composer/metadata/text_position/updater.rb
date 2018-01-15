module Composer
  module Metadata
    module TextPosition
      class Updater

        attr_reader :metadata

        def initialize(metadata)
          @metadata = metadata.with_indifferent_access
        end

        def update!(grid_position:, layout_dimension:, image_dimension:, keys:)
          @layout_dimension = layout_dimension
          @image_dimension  = image_dimension

          initial_value = metadata.dig(*keys)

          new_value = nil
          if keys.last.downcase.to_sym == :latitude
            new_value = latitude_text_position(initial_value: initial_value, position: grid_position)
          else
            new_value = longitude_text_position(initial_value: initial_value, position: grid_position)
          end
          update_metadata(keys: keys, value: new_value)

          nil
        end

        private

        attr_reader :grid_position, :layout_dimension, :image_dimension

        def latitude_text_position(initial_value:, position:)
          position.x / layout_dimension.width + image_dimension.width * initial_value / layout_dimension.width
        end

        def longitude_text_position(initial_value:, position:)
          position.y / layout_dimension.height + image_dimension.width * initial_value / layout_dimension.height
        end

        def update_metadata(keys:, value:)
          *key, last = keys
          key.inject(metadata, :fetch)[last] = value
        end

      end
    end
  end
end
