require "spec_helper"

describe CsvConvert::Common::Row do

  let(:instance) do
    described_class.new(raw_data: raw_data)
  end

  context do
    let(:raw_data) { "  --- FormDataField has missing image {id= 527376, uuid= fe7ba3d5-ab9f-413a-8e14-072454cbabeb}" }

    it do
      expect(instance).to_not be_skip
      expect(instance.to_row).to eql({ id: 527376, uuid: 'fe7ba3d5-ab9f-413a-8e14-072454cbabeb' })
    end
  end

  context do
    let(:raw_data) { "  Foo Bar Zone" }

    it do
      expect(instance).to be_skip
    end
  end
end
