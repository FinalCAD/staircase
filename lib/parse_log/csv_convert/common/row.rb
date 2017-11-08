module CsvConvert
  module Common
    class Row

      def initialize(raw_data:)
        @raw_data = raw_data
      end

      def skip?
        return true unless raw_data
        if raw_data.to_s.match(/FormDataField has missing image|------- Image/)
          return false
        end
        true
      end

      def to_row
        m = raw_data.to_s.match(line_regular_expression)
        {
          id: m[:field_value_id].to_i,
          uuid: m[:field_value_uuid]
        }
      end

      private

      attr_reader :raw_data, :match

      REGEXP = /^  --- FormDataField has missing image {id= (?<field_value_id>\d*), uuid= (?<field_value_uuid>.*)}$/.freeze
      private_constant :REGEXP

      def line_regular_expression
        REGEXP
      end

    end
  end
end
