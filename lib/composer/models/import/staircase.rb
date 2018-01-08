module Composer
  module Models
    module Import
      class Staircase
        include Base

        attr_reader :sectors

        def initialize(model)
          super
          @sectors = {}
        end

        def name
          model.exploded_path.last
        end
        alias_method :full_name, :name

        def dir_path
          "Staircases#{File::SEPARATOR}#{name}"
        end

        def number_of_images
          sectors.keys.count
        end

        alias_method :full_path, :source_path

        def append_sector(sector)
          sectors[sector.name] ||= sector
        end

      end
    end
  end
end
