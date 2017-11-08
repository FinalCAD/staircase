require "spec_helper"

describe CsvConvert::Models::Image do

  let(:instance) do
    described_class.new(raw_data: raw_data)
  end

  let(:raw_data) { "  ------- Image {url= https://finalcloud-prod.s3.amazonaws.com/ios-uploads/9c633ebd59f7285f0881b26a502b9953/projects/14420/field_values/1BFBB184-DAB6-4FF2-8C68-A58883143F87.jpeg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJ2AVUFF7SZ5XG3GQ%2F20171108%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20171108T132119Z&X-Amz-Expires=518400&X-Amz-SignedHeaders=host&X-Amz-Signature=b5888aee97359b118606efd3eded0a39c8b8e620e591e150ea93b323daca712b, md5= 41957ac7ee2b16396f109e7500ecad64" }

  it do
    expect(instance.to_row).to eql({ project_id: 14420, extension: ".jpeg", md5: "41957ac7ee2b16396f109e7500ecad64" })
  end
end
