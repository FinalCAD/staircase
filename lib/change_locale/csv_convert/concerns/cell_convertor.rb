module CsvConvert
  module Pro
    class CellConvertor

      def initialize(cell, type=String)
        @cell = cell
        @type = type
      end

      def to_cell
        if @type == String
          @cell
        elsif @type == Types::DateType
          Types::DateType.new(@cell).to_cell
        elsif @type == Types::CurrencyType
          Types::CurrencyType.new(@cell).to_cell
        else
          raise "Unknow type convertion"
        end
      end

    end
  end
end
