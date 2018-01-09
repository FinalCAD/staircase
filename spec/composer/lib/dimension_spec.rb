require 'spec_helper'

describe Composer::Lib::Dimension do
  [
    { width: 2109.0, height: 1818.0, ratio: 1.16 },
    { width: 994.5,  height: 897.0,  ratio: 1.11 }
  ].each do |dimension|
    it do
      expect(
        described_class.new(height: dimension[:height], width: dimension[:width]).ratio
      ).to eql(dimension[:ratio])
    end
  end
end
