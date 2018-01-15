module Composer
  module Metadata
    class TextPosition
      include Composer::Metadata::Base

      protected

      def _update!(initial_value, position, keys)
        if keys.last.downcase.to_sym == :latitude
          width_position(initial_value: initial_value, position: position)
        else
          height_position(initial_value: initial_value, position: position)
        end
      end

    end
  end
end
