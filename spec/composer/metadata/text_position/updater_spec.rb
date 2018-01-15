require 'spec_helper'

describe Composer::Metadata::TextPosition::Updater do
  let(:number_of_images) { 4 }
  let(:marge)            { Composer::Lib::Dimension.new(height: 8.0, width: 40.0) }
  let(:grid)             { Composer::Lib::Grid.new(number_of_images) }
  let(:layout_dimension) { Composer::Lib::Dimension.new(width: 2109.0, height: 1818.0) }
  let(:size)             { Composer::Lib::Size.new(grid: grid, layout_dimension: layout_dimension, marge: 40.0).call }

  let(:zone_metadata) do
    {
      "ZoneName": "A Zone Name",
      "TextPosition": {
        "Latitude":  0.31459217736659406,
        "Longitude": 0.19305768725829608
      },
      "TextPositionULC": {
        "Latitude":  0.16939172393953597,
        "Longitude": 0.11502847201416377
      },
      "TextPositionBRC": {
        "Latitude":  0.45979263079365207,
        "Longitude": 0.27108690250242806
      }
    }
  end

  let(:computed_zone_metadata) do
    {
      "TextPosition": {
        "Latitude":  0.1658804340864668,
        "Longitude": 0.10898928282766547
      },
      "TextPositionBRC": {
        "Latitude":  0.23368883929287243,
        "Longitude": 0.1512615458056333
      },
      "TextPositionULC": {
        "Latitude":  0.09807202888006117,
        "Longitude": 0.06671701984969741
      }
    }
  end

  subject { described_class.new(zone_metadata) }

  # let(:sector_position)  { Composer::Lib::SectorPosition.new(dimension: size.image_dimension, marge: marge, footer: 32.0) }

  it do
    first_position = marge
    # first_position = sector_position.coordinate(column: 0, row: 0)

    [
      [ :TextPosition,    :Latitude  ],
      [ :TextPosition,    :Longitude ],
      [ :TextPositionBRC, :Latitude  ],
      [ :TextPositionBRC, :Longitude ],
      [ :TextPositionULC, :Latitude  ],
      [ :TextPositionULC, :Longitude ],
    ].each do |keys|
      initial_value = zone_metadata.dig(*keys)

      expect {
        subject.update!(
          grid_position:    first_position,
          layout_dimension: layout_dimension,
          image_dimension:  size.image_dimension,
          keys:             keys
        )
      }.to change {
        subject.metadata.dig(*keys)
      }.from(
        initial_value
      ).to(
        computed_zone_metadata.dig(*keys)
      )
    end
  end
end
