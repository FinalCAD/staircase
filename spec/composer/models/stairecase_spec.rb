require 'spec_helper'

describe Composer::Models::Staircase do
  let(:name) { 'A Staircase' }
  let(:path) { 'a/path/whatever/where' }

  subject { described_class.new(name, path) }

  it do
    expect(subject.name).to eql('A Staircase')
    expect(subject.source_path.to_s).to eql("#{path}/#{name}")
    expect(subject.source_path).to_not be_exists
    expect(subject.sectors).to eql({})
  end

  describe '#append_sector' do
    let(:sector_name) { 'A Sector.png' }
    let(:sector_path) { 'a/path/whatever/where/A Sector.png' }

    let(:sector) { Composer::Models::Sector.new(sector_name, sector_path) }

    it do
      expect {
        subject.append_sector(sector)
      }.to change {
        subject.sectors.keys
      }.from([]).to(['A Sector'])

      expect(subject.sectors['A Sector']).to eql(sector)
      expect(subject.sectors['A Sector'].source_path(:png).to_s).to eql(sector_path)
    end
  end
end
