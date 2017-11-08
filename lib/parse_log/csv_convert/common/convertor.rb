module CsvConvert
  module Common
    class Convertor

      def initialize
        @rows = []
      end

      def convert(file_path:, output_dir: '~/Downloads/')
        read(file_path)
        puts("Path :: #{write(output_dir)}")
      end

      def date_format
        "#{Time.now.strftime("%y%m%d")}"
      end

      private

      def read(file_path)
        previous = nil

        File.open(file_path).each do |line|
          current_line = Row.new(raw_data: line)
          next if current_line.skip?

          if previous
            previous.image = Models::Image.new(raw_data: line)
            rows << previous.to_row
            previous = nil
          else
            previous = Models::FieldValue.new(row_data: current_line.to_row)
          end
        end

        nil
      end

      def write(output_dir)
        output_full_path = "#{output_dir}/#{date_format}_converted_file.csv"

        CSV.open(output_full_path, 'w') do |csv|
          csv << headers

          rows.each do |row|
            csv << row.values
          end
        end

        output_full_path
      end

      def headers
        %w(id uuid project_id extension md5)
      end

      attr_reader :rows
    end
  end
end
