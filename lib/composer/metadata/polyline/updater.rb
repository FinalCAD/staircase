module Composer
  module Metadata
    module Polyline
      class Updater
        include Composer::Metadata::Base

        protected

        def _update!(initial_value, position, keys)
          [].tap do |new_value|
            new_value << initial_value[0].map do |x, y|
              [
                width_position(initial_value:  x, position: position),
                height_position(initial_value: y, position: position)
              ]
            end
          end
        end

      end
    end
  end
end
