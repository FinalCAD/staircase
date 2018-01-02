require 'spec_helper'

describe Composer::Models::Import::Staircase do
  let(:path)    { 'a/path/whatever/where/Staircases/A Staircase' }
  let(:context) {{ }}
  let(:model)   { Composer::Model.new(path, context) }

  subject { described_class.new(model) }

  it do
    expect(subject.name).to eql('A Staircase')
    expect(subject.full_name).to eql('A Staircase')

    expect(subject.root_path).to eql('a/path/whatever/where')
    expect(subject.source_path).to eql('a/path/whatever/where/Staircases/A Staircase')
    expect(subject.full_path.to_s).to  eql('a/path/whatever/where/Staircases/A Staircase')
    expect(subject.dir_path).to  eql('Staircases/A Staircase')

    expect(subject.sectors).to eql({})
  end

  describe '#append_sector' do
    let(:sector_path)    { 'a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png' }
    let(:sector_context) {{ }}
    let(:sector)         { Composer::Models::Import::Sector.new(Composer::Model.new(sector_path, sector_context)) }

    it do
      expect {
        subject.append_sector(sector)
      }.to change {
        subject.sectors.keys
      }.from([]).to(['A Sector'])

      expect(subject.sectors['A Sector']).to eql(sector)
      expect(subject.sectors['A Sector'].full_path.to_s).to eql('a/path/whatever/where/Staircases/A Staircase/Sectors/A Sector.png')
    end
  end
end
