module Composer
  module Processors
    module Metadata
      class Zone < Base

        def process(staircase_model)
          staircase_model.sectors.each do |_, sector_model|
            sector_model.zones.each do |_, zone_model|
              metadata = JSON.load(File.new(zone_model.full_path(:json).path.to_s).read)

              metadata['SubView']['SectorName'] = staircase_model.name

              file = Tempfile.new(%W[zone_metadata .json])
              file.write(metadata.to_json)
              file.rewind

              copy(file, zone_path(staircase_model, sector_model, zone_model))

              file.close
              file.unlink # deletes the temp file
            end
          end

          nil
        end

        private

        # Zones\<Staircase Name>\<Sector Name> <Zone name>.json
        def zone_path(staircase_model, sector_model, zone_model)
          OpenStruct.new(
            path: [ export_path, 'Zones', staircase_model.name, "#{sector_model.name} #{zone_model.name}.json" ].join(File::SEPARATOR)
          )
        end

      end
    end
  end
end
