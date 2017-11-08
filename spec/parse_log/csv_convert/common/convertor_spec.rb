require "spec_helper"
require 'csv'

describe CsvConvert::Common::Convertor do
  let(:instance) do
    described_class.new
  end

  before do
    instance.convert(file_path: 'spec/fixtures/14420_Missing_images.txt', output_dir: 'spec/fixtures')
  end

  after do
    FileUtils.rm(output_file_path, force: true)
  end

  let(:output_file_path) { "spec/fixtures/#{instance.date_format}_converted_file.csv" }

  it do
    data = []
    CSV.foreach(output_file_path) { |row| data << row }
    expect(data[0]).to eql(["id", "uuid", "project_id", "extension", "md5"])
    expect(data[1]).to eql(["527376", "fe7ba3d5-ab9f-413a-8e14-072454cbabeb", "14420", ".jpeg", "41957ac7ee2b16396f109e7500ecad64"])
  end
end
