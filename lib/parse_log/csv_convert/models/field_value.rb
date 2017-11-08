module CsvConvert
  module Models
    class FieldValue

      attr_reader :id, :uuid, :image

      def initialize(row_data:)
        @row_data = row_data
        @id       = row_data[:id]
        @uuid     = row_data[:uuid]
      end

      def image=(image)
        @image = image
      end

      def to_row
        @row_data.merge(image.to_row)
      end

    end
  end
end
