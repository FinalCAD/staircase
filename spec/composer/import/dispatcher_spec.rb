require 'spec_helper'
require 'ostruct'

describe Composer::Import::Dispatcher do

  context 'Add a Staircase' do
    let(:model)    { Composer::Model.new('spec/fixtures/archive/input/Staircases/Staircase Name 1') }
    let(:registry) { Composer::Stores::Register.get }

    it do
      expect {
        subject.dispatch(model)
      }.to change {
        registry.staircases.keys
      }.from([]).to(['Staircase Name 1'])

      path = "spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors/R+1.json"
      model = Composer::Model.new(path)
      staircase = registry.staircases['Staircase Name 1']

      expect {
        subject.dispatch(model)
      }.to change {
        staircase.sectors.keys
      }.from([]).to(['R+1'])

      path = "spec/fixtures/archive/input/Staircases/Staircase Name 1/Zones/R+1/Logement 12-11-=-Architecte.png"
      model = Composer::Model.new(path)
      sector = registry.staircases['Staircase Name 1'].sectors['R+1']

      expect {
        subject.dispatch(model)
      }.to change {
        sector.zones.keys
      }.from([]).to(['Logement 12-11-=-Architecte'])
    end
  end
end
