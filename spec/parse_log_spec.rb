require 'spec_helper'

describe ParseLog do

  let(:instance) do
    described_class.new
  end

  # it do
  #   expect(
  #     instance.option_parser.parse!(%w[--help])
  #   ).to eql(
  #     <<-STR
  #     Usage: example.rb [options]
  #   -f, --file       INPUT_FILE_PATH [REQUIRED] File path
  #   -o, --output_dir OUTPUT_DIR_PATH [OPTIONAL] Output dir path
  #   -h, --help                       Prints this help
  #   STR
  #   )
  # end
end
