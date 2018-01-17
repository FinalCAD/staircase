module Composer
  module Processors
    class MoveZone < Base

      def process(staircase_model)
        staircase_model.sectors.each do |_, sector_model|
          sector_model.zones.each do |_, zone_model|
            copy(zone_model.full_path(:png), zone_path(staircase_model, sector_model, zone_model))
          end
        end
      end

      private

      # Zones\<Staircase Name>\<Sector Name> <Zone name>.png
      def zone_path(staircase_model, sector_model, zone_model)
        OpenStruct.new(
          path: [ export_path, 'Zones', staircase_model.name, "#{sector_model.name} #{zone_model.name}.png" ].join(File::SEPARATOR)
        )
      end

    end
  end
end
