module Composer
  module Processors
    module Metadata
      class Sector < Base

        def metadata_template
          {
            "Sector": {
              "Zones": [],
              "Tags": [],
              "WidthMeters": nil,
              "AngleWithNorth": 0,
              "SectorName": nil,
              "HasValidNorth": false
            }
          }
        end

        def process(staircase_model)
          metadata = metadata_template

          metadata[:Sector][:SectorName] = staircase_model.name

          tags = []
          staircase_model.sectors.each do |_, sector_model|
            sector_metadata = JSON.load(File.new(sector_model.full_path(:json).path.to_s).read)
            tags << Array(sector_metadata[:Tags])
          end
          metadata[:Sector][:Tags] = tags.flatten.compact.uniq.sort

          file = Tempfile.new(%W[sector_metadata .json])
          file.write(metadata.to_json)
          file.rewind

          copy(file, sector_path(staircase_model))

          file.close
          file.unlink # deletes the temp file

          nil
        end

        private

        # Sectors\<Staircase Name>.json
        def sector_path(model)
          OpenStruct.new(
            path: [ export_path, "Sectors", "#{model.name}.json" ].join(File::SEPARATOR)
          )
        end

      end
    end
  end
end
