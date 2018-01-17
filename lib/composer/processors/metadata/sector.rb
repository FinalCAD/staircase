module Composer
  module Processors
    module Metadata
      class Sector < Base

        def process(staircase_model)
          super

          metadata = metadata_template

          metadata[:Sector][:SectorName] = staircase_model.name

          tags = []
          staircase_model.sectors.each do |_, sector_model|
            sector_metadata = JSON.load(File.new(sector_model.full_path(:json).path.to_s).read)
            tags << Array(sector_metadata[:Tags])

            cell = grid.move
            position = sector_position.coordinate(column: cell.column.to_i, row: cell.row.to_i)

            sector_model.zones.each do |_, zone_model|
              zone_metadata = zone_metadata(sector_metadata, zone_model.short_name)
              updater = Composer::Metadata::TextPosition.new(
                metadata:         zone_metadata,
                layout_dimension: layout_dimension,
                image_dimension:  size.image_dimension)

              text_position_keys.each do |keys|
                updater.update!(position: position, keys: keys)
              end

              updater = Composer::Metadata::Polyline.new(
                metadata:         zone_metadata,
                layout_dimension: layout_dimension,
                image_dimension:  size.image_dimension)

              polyline_keys.each do |keys|
                updater.update!(position: position, keys: keys)
              end

              updater.metadata['ZoneName']  = "#{sector_model.name} #{zone_model.short_name}"
              updater.metadata['ShortName'] = "#{sector_model.name} #{zone_model.short_name}"

              metadata[:Sector][:Zones] << updater.metadata
            end
          end

          metadata[:Sector][:Tags] = tags.flatten.compact.uniq.sort

          file = write(%W[sector_metadata .json], metadata.to_json)
          copy(file, sector_path(staircase_model))

          nil
        end

        private

        def text_position_keys
          [
            [ :TextPosition,    :Latitude  ],
            [ :TextPosition,    :Longitude ],
            [ :TextPositionBRC, :Latitude  ],
            [ :TextPositionBRC, :Longitude ],
            [ :TextPositionULC, :Latitude  ],
            [ :TextPositionULC, :Longitude ],
          ]
        end

        def polyline_keys
          [[ :Polyline, :coordinates ]]
        end

        # Sectors\<Staircase Name>.json
        def sector_path(model)
          OpenStruct.new(
            path: [ export_path, "Sectors", "#{model.name}.json" ].join(File::SEPARATOR)
          )
        end

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

        def zone_metadata(sector_metadata, zone_name)
          sector_metadata['Sector']['Zones'].detect { |zone| zone['ZoneName'] == zone_name }
        end

      end
    end
  end
end
