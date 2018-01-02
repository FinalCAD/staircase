require 'spec_helper'

describe Composer::Models::Import::Sector do
  let(:path)    { 'a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png' }
  let(:context) {{ }}
  let(:model)   { Composer::Model.new(path, context) }

  subject { described_class.new(model) }

  it do
    expect(subject.name).to             eql('A Sector')
    expect(subject.extension).to        eql('png')
    expect(subject.full_name).to        eql('A Sector.png')

    expect(subject.root_path).to        eql('a/path/whatever/where')
    expect(subject.source_path).to      eql('a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png')
    expect(subject.dir_path).to         eql('Staircases/A Staircase/Sectors')
    expect(subject.full_path.to_s).to        eql('a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png')
    expect(subject.full_path(:pdf).to_s).to  eql('a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.pdf')

    expect(subject.zones).to eql({})
  end

  describe '#append_zone' do
    let(:zone_path)    { 'a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone.png' }
    let(:zone_context) {{ }}
    let(:zone)         { Composer::Models::Import::Zone.new(Composer::Model.new(zone_path, zone_context)) }

    it do
      expect {
        subject.append_zone(zone)
      }.to change {
        subject.zones.keys
      }.from([]).to(['A Zone'])

      expect(subject.zones['A Zone']).to eql(zone)
      expect(subject.zones['A Zone'].full_path.to_s).to eql('a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone.png')
    end
  end
end
