require 'spec_helper'
require 'ostruct'

describe Composer::Import::Instantiate do

  context 'Add a Staircase' do
    let(:model)    { Composer::Model.new('spec/fixtures/archive/input/Staircases/Staircase Name 1') }
    let(:registry) { Composer::Stores::Registry.instance }

    [
      'spec/fixtures/archive/input/Staircases',
      'spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors',
      'spec/fixtures/archive/input/Staircases/Staircase Name 1/Zones/R+1'
    ].each do |path_to_ignore|
      it { expect(subject.call(Composer::Model.new(path_to_ignore))).to eql(false) }
    end

    it do
      expect {
        expect(subject.call(model)).to eql(true)
      }.to change {
        registry.inputs.keys
      }.from([]).to(['Staircase Name 1'])

      path = "spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors/R+1.json"
      model = Composer::Model.new(path)
      staircase = registry.inputs['Staircase Name 1']

      expect {
        expect(subject.call(model)).to eql(true)
      }.to change {
        staircase.sectors.keys
      }.from([]).to(['R+1'])

      path = "spec/fixtures/archive/input/Staircases/Staircase Name 1/Zones/R+1/Logement 12-11-=-Architecte.png"
      model = Composer::Model.new(path)
      sector = registry.inputs['Staircase Name 1'].sectors['R+1']

      expect {
        expect(subject.call(model)).to eql(true)
      }.to change {
        sector.zones.keys
      }.from([]).to(['Logement 12-11-=-Architecte'])
    end
  end
end
