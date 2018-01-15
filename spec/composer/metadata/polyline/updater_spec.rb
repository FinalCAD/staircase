require 'spec_helper'

describe Composer::Metadata::Polyline::Updater do
  let(:number_of_images) { 4 }
  let(:marge)            { Composer::Lib::Dimension.new(height: 8.0, width: 40.0) }
  let(:grid)             { Composer::Lib::Grid.new(number_of_images) }
  let(:layout_dimension) { Composer::Lib::Dimension.new(width: 2109.0, height: 1818.0) }
  let(:size)             { Composer::Lib::Size.new(grid: grid, layout_dimension: layout_dimension, marge: 40.0).call }

  let(:zone_metadata) do
    {
      "Polyline": {
        "coordinates": [
          [
            [
              0.48244855791501523,
              0.4719195522192441
            ],
            [
              0.35823627075203746,
              0.4719195522192441
            ],
            [
              0.35823627075203746,
              0.3502002554925445
            ],
            [
              0.6078175803211607,
              0.3502002554925482
            ],
            [
              0.6078175802113838,
              0.4217998349283555
            ],
            [
              0.5333675040500282,
              0.42179983477849337
            ],
            [
              0.5333674978336176,
              0.6061687500341326
            ],
            [
              0.48244802606158527,
              0.6061687500341328
            ],
            [
              0.48244855791501523,
              0.4719195522192441
            ]
          ]
        ]
      }
    }
  end

  let(:computed_zone_metadata) do
    {
      "Polyline": {
        "coordinates": [
          [
            [
              0.24426912503105666,
              0.26006246808621203
            ],
            [
              0.18626216361483247,
              0.26006246808621203
            ],
            [
              0.18626216361483247,
              0.1941211395129852
            ],
            [
              0.3028162801604131,
              0.19412113951298718
            ],
            [
              0.3028162801091474,
              0.2329101525967752
            ],
            [
              0.26804820044517436,
              0.2329101525155875
            ],
            [
              0.26804819754211945,
              0.33279186023576307
            ],
            [
              0.2442688766562614,
              0.3327918602357632
            ],
            [
              0.24426912503105666,
              0.26006246808621203
            ]
          ]
        ]
      }
    }
  end

  subject { described_class.new(metadata: zone_metadata, layout_dimension: layout_dimension, image_dimension: size.image_dimension) }

  # let(:sector_position)  { Composer::Lib::SectorPosition.new(dimension: size.image_dimension, marge: marge, footer: 32.0) }

  it do
    first_position = marge
    # first_position = sector_position.coordinate(column: 0, row: 0)

    keys = [ :Polyline, :coordinates ]

    initial_value = zone_metadata.dig(*keys)

    expect {
      subject.update!(
        position: first_position,
        keys:     keys
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
