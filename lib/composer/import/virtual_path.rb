module Composer
  module Import
    class VirtualPath
      def initialize(source_path)
        @source_path = source_path
      end

      def to_s
        source_path
      end

      def path
        Lib::SafePath.new(source_path).path
      end

      def exists?
        File.exists?(source_path)
      end

      private

      attr_reader :source_path
    end
  end
end
