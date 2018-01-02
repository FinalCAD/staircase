module Composer
  module Processors
    class Base

      attr_reader :exporter

      def initialize(exporter)
        @exporter = exporter
      end

    end
  end
end
