require 'spec_helper'

describe Composer::Lib::Point do

  subject { described_class.new(y: 8.0, x: 40.0) }

  it do
    expect(subject.to_s).to eql('+40.0+8.0')
  end
end
