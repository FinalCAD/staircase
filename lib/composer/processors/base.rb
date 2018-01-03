module Composer
  module Processors
    class Base

      attr_reader :exporter

      def initialize(exporter)
        @exporter = exporter
      end

      private

      def convert(file)
        return unless file.exists?
        converter.constantize.new(file, convert_options: convert_options).process
      end

      def copy(from, to)
        FileUtils.cp(from.path, to.path)
      end

    end
  end
end
