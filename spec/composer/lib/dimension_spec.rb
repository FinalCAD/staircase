require 'spec_helper'

describe Composer::Lib::Dimension do
  [
    { width: 2109.0, height: 1818.0, ratio: 1.16, to_s: '2109.0x1818.0' },
    { width: 994.5,  height: 897.0,  ratio: 1.11, to_s: '994.5x897.0' }
  ].each do |dimension|
    it do
      instance = described_class.new(height: dimension[:height], width: dimension[:width])
      expect(instance.ratio).to eql(dimension[:ratio])
      expect(instance.to_s).to eql(dimension[:to_s])
    end
  end
end
