module CsvConvert
  module Pro
    class RowConvertor

      def initialize(row)
        @row = row
      end

      def to_row
        row = Array.new(7)
        @row.each_with_index do |cell, index|
          next unless matrix[index]
          type = convertors.fetch(index, String)
          row[matrix[index]] = CellConvertor.new(cell, type).to_cell
        end
        row
      end

      private

      def matrix
        {
          0 => 0,
          1 => nil, # ignored
          2 => 1,
          3 => 2,
          4 => 4,
          5 => 7,
          6 => nil # ignored
        }
      end

      def convertors
        {
          0 => Types::DateType,
          4 => Types::CurrencyType,
          5 => Types::CurrencyType
        }
      end

    end
  end
end
