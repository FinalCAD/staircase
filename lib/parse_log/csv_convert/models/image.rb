module CsvConvert
  module Models
    class Image

      def initialize(raw_data:)
        @raw_data = raw_data
      end

      def to_row
        m = raw_data.to_s.match(line_regular_expression)
        unless m
          {
            project_id: nil,
            extension: nil,
            md5: nil
          }
        else
          {
            project_id: m[:project_id].to_i,
            extension: m[:extension],
            md5: m[:md5].to_s
          }
        end
      end

      private

      attr_reader :raw_data, :match

      REGEXP = /^  ------- Image {url= https:\/\/finalcloud-prod\.s3\.amazonaws\.com\/ios-uploads\/\w*\/projects\/(?<project_id>\d*)\/field_values\/\w*-\w*-\w*-\w*-\w*(?<extension>\..*)\?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=\w*%\w*%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=\w*&X-Amz-Expires=\d*&X-Amz-SignedHeaders=host&X-Amz-Signature=\w*, md5= (?<md5>.*)$/.freeze
      private_constant :REGEXP

      def line_regular_expression
        REGEXP
      end

    end
  end
end
