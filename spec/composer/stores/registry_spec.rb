require 'spec_helper'

describe Composer::Stores::Registry do
  let(:model) { instance_double('Composer::Models::Staircase') }

  subject { Composer::Stores::Registry.instance }

  before { subject.reset! }

  it do
    expect(subject.inputs).to  eql({})
    expect(subject.outputs).to eql({})
  end

  context do
    before { expect(model).to receive(:name).and_return(nil) }
    it do
      expect {
        subject.append_input(model)
      }.to_not change {
        subject.inputs
      }
    end
  end

  context do
    before { expect(model).to receive(:name).at_least(:once).and_return('A Name') }
    it do
      expect {
        subject.append_input(model)
      }.to change {
        subject.inputs.keys
      }.from([]).to(['A Name'])
    end
  end
end
