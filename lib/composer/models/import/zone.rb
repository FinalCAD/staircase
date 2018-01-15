module Composer
  module Models
    module Import
      class Zone
        include Base
        include FileBase

        private

        def _name
          if super =~ /-=-/
            super.split('-=-').first
          elsif super =~ /-==-/
            super.split('-=+-').first
          else
            super
          end
        end

      end
    end
  end
end
