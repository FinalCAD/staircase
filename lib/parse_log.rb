require_relative 'parse_log/csv_convert/common/row'
require_relative 'parse_log/csv_convert/common/convertor'

require_relative 'parse_log/csv_convert/models/field_value'
require_relative 'parse_log/csv_convert/models/image'

require 'optparse'
require 'optparse/date'

require 'csv'

class ParseLog

  def initialize
    @options = {}
  end

  def convert
    @file_path = options[:file_path]

    CsvConvert::Common::Convertor.new.convert(file_path: file_path, output_dir: options[:output_dir])
  end

  def option_parser
    opts = OptionParser.new

    opts.banner = "Usage: example.rb [options]"

    opts.on('-f INPUT_FILE_PATH', '--file INPUT_FILE_PATH', '[REQUIRED] File path', String) do |file_path|
      @options[:file_path] = file_path
    end

    opts.on('-o OUTPUT_DIR_PATH', '--output_dir OUTPUT_DIR_PATH', '[OPTIONAL] Output dir path', String) do |output_dir|
      @options[:output_dir] = output_dir
    end

    opts.on('-h', '--help', 'Prints this help') do
      puts opts
      exit(0)
    end

    opts
  end

  attr_reader :options

  private

  attr_reader :file_path
end
