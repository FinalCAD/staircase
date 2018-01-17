require 'spec_helper'

describe Composer::Configuration do

  it do
    expect(subject.layout).to include({
      dimension: { width: 2109.0, height: 1818.0 },
      marge:     { width: 40.0,   height: 8.0    },
      footer: 32.0 })
  end
end
