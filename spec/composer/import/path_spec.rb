require 'spec_helper'

describe Composer::Import::Path do
  let(:source_path) { 'spec/fixtures/archive/input' }
  let(:instance)    { described_class.new(source_path) }

  describe '#size' do
    subject { instance.size }

    it 'should return number of paths' do
      expect(subject).to eql(24)
    end
  end

  describe '#reset!' do
    subject { instance.reset! }

    it 'sets the state back to reset!' do
      expect(instance.read_path).to eql('spec/fixtures/archive/input/Staircases')
      second_path? instance
      subject
      start? instance
      expect(instance.read_path).to eql('spec/fixtures/archive/input/Staircases')
    end

    def second_path?(instance)
      expect(instance.index).to eql(0)
      expect(instance.current_path).to eql('spec/fixtures/archive/input/Staircases')
    end
  end

  describe '#start?' do
    subject { instance.start? }

    it 'works' do
      expect(subject).to be_truthy
    end
  end

  describe '#end?' do
    subject { instance.end? }

    it 'works' do
      while instance.read_path; end
      expect(subject).to be_truthy
    end
  end

  describe '#next_path' do
    subject { instance.next_path }

    it 'returns the next path without changing the state' do
      start? instance
      expect(subject).to eql('spec/fixtures/archive/input/Staircases')
      start? instance
    end
  end

  describe '#pointer' do
    before { 2.times.each { instance.read_path }}

    it 'works and goes to end paths' do
      expect(instance.previous_path).to eql('spec/fixtures/archive/input/Staircases')
      expect(instance.current_path).to  eql('spec/fixtures/archive/input/Staircases/Staircase Name 1')
      expect(instance.next_path).to     eql('spec/fixtures/archive/input/Staircases/Staircase Name 1/Sectors')
    end
  end

  def start?(instance)
    expect(instance.index).to eql(-1)
    expect(instance.current_path).to be_nil
  end

  describe '#read_path' do

    it 'works and goes to end paths' do
      expect(instance.read_path).to eql('spec/fixtures/archive/input/Staircases')
      expect(instance.read_path).to eql('spec/fixtures/archive/input/Staircases/Staircase Name 1')
      # and so on....
    end
  end
end
