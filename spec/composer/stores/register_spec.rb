require 'spec_helper'

describe Composer::Stores::Register do

  it do
    expect(Composer::Stores::Register.get).to eql(described_class.instance)
  end

end
