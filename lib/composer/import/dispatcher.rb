module Composer
  module Import
    class Dispatcher

      attr_reader :registry

      def initialize(registry=Stores::Registry)
        @registry ||= registry.instance
      end

      def dispatch(model)
        return if is_nothing?(model) # A/Path/Staircases

        if is_staircase?(model) # A/Path/Staircases/<Staircase Name>
          staircase = Models::Staircase.new(model.staircase_name, model.source_path)
          registry.append_input(staircase)

        elsif is_localisation?(model) # A/Path/Staircases/<Staircase Name>/Sectors/<Sector Name>.<extension>
          if localisation_type(model) == 'Sectors'
            sector = Models::Sector.new(sector_name(model), model.source_path)
            registry.inputs[model.staircase_name].append_sector(sector)
          else
            return unless zone_name(model) # A/Path/Staircases/<Staircase Name>/Zones/<Sector Name>/

            zone = Models::Zone.new(zone_name(model), model.source_path)
            sector = registry.inputs[model.staircase_name].sectors[sector_name(model)]
            sector.append_zone(zone)
          end
        end
      end

      private

      def is_nothing?(model)
        model.exploded_path[ model.staircase_index ].nil?
      end

      def is_staircase?(model)
        model.exploded_path[ model.staircase_index + 1 ].nil?
      end

      def is_localisation?(model)
        !model.exploded_path[ model.staircase_index + 2 ].nil?
      end

      def localisation_type(model)
        model.exploded_path[ model.staircase_index + 1 ]
      end

      def sector_name(model)
        model.exploded_path[ model.staircase_index + 2 ]
      end

      def zone_name(model)
        model.exploded_path[ model.staircase_index + 3 ]
      end
    end
  end
end
