module Composer
  module Metadata
    module TextPosition
      class Updater
        include Composer::Metadata::Base

        def update!(position:, keys:)
          initial_value = metadata.dig(*keys)
          return unless initial_value

          new_value = nil
          if keys.last.downcase.to_sym == :latitude
            new_value = width_position(initial_value: initial_value, position: position)
          else
            new_value = height_position(initial_value: initial_value, position: position)
          end

          update_metadata(keys: keys, value: new_value)
          nil
        end

      end
    end
  end
end
