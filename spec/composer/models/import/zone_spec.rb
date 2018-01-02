require 'spec_helper'

describe Composer::Models::Import::Zone do
  let(:path)    { 'a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone.png' }
  let(:context) {{ }}
  let(:model)   { Composer::Model.new(path, context) }

  subject { described_class.new(model) }

  it do
    expect(subject.name).to             eql('A Zone')
    expect(subject.extension).to        eql('png')
    expect(subject.full_name).to        eql('A Zone.png')

    expect(subject.root_path).to        eql('a/path/whatever/where')
    expect(subject.source_path).to      eql('a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone.png')
    expect(subject.dir_path).to         eql('Staircases/A Staircase/Zones/A Sector')
    expect(subject.full_path.to_s).to        eql('a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone.png')
    expect(subject.full_path(:pdf).to_s).to  eql('a/path/whatever/where/Staircases/A Staircase/Zones/A Sector/A Zone.pdf')
  end
end
