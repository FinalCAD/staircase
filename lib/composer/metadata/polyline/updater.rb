module Composer
  module Metadata
    module Polyline
      class Updater
        include Composer::Metadata::Base

        def update!(position:, keys:)
          initial_value = metadata.dig(*keys)
          return unless initial_value

          new_value = []
          new_value << initial_value[0].map do |x, y|
            [
              width_position(initial_value:  x, position: position),
              height_position(initial_value: y, position: position)
            ]
          end

          update_metadata(keys: keys, value: new_value)
          nil
        end

      end
    end
  end
end
