module CsvConvert
  module Pro
    class ArrayConvertor

      def initialize(rows)
        @rows = rows
      end

      def to_rows
        @rows.map do |row|
          RowConvertor.new(row).to_row
        end
      end

    end
  end
end
