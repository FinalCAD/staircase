require 'spec_helper'

describe Composer do

  before do
    Composer.configure do |config|
      config.layout = { a: :hash }
    end
  end

  it do
    expect(Composer.configuration.layout).to eql({ a: :hash })
  end

  after do
    Composer.reset
  end
end
