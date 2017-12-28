require 'spec_helper'

describe Composer::Models::Sector do
  let(:name) { 'A Sector.png' }
  let(:path) { 'a/path/whatever/where/A Sector.png' }

  subject { described_class.new(name, path) }

  it do
    expect(subject.name).to eql('A Sector')
    expect(subject.path(:png).to_s).to eql(path)
    expect(subject.path(:png)).to_not be_exists
    expect(subject.zones).to eql({})
  end

  describe '#append_zone' do
    let(:zone_name) { 'A Zone.png' }
    let(:zone_path) { 'a/path/whatever/where/A Zone.png' }

    let(:zone) { Composer::Models::Zone.new(zone_name, zone_path) }

    it do
      expect {
        subject.append_zone(zone)
      }.to change {
        subject.zones.keys
      }.from([]).to(['A Zone'])

      expect(subject.zones['A Zone']).to eql(zone)
      expect(subject.zones['A Zone'].path(:png).to_s).to eql(zone_path)
      expect(subject.path(:png)).to_not be_exists
    end
  end
end
