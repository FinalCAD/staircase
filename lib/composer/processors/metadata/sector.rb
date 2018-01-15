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
              zone_metadata = zone_metadata(sector_metadata, zone_name(zone_model.name))
              updater = Composer::Metadata::TextPosition::Updater.new(zone_metadata)

              text_position_keys.each do |keys|
                updater.update!(
                    grid_position: position,
                    layout_dimension: layout_dimension,
                    image_dimension: size.image_dimension,
                    keys: keys)
              end

              metadata[:Sector][:Zones] << updater.metadata
            end
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

        def zone_name(model_name)
          if model_name =~ /-=-/
            model_name.split('-=-').first
          elsif model_name =~ /-==-/
            model_name.split('-=+-').first
          else
            model_name
          end
        end

      end
    end
  end
end
