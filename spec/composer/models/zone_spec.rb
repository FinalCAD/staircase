require 'spec_helper'

describe Composer::Models::Zone do
  let(:name) { 'A Zone.png' }
  let(:path) { 'a/path/whatever/where/A Zone.png' }

  subject { described_class.new(name, path) }

  it do
    expect(subject.name).to eql('A Zone')
    expect(subject.source_path(:png).to_s).to eql(path)
    expect(subject.source_path(:png)).to_not be_exists
  end
end
