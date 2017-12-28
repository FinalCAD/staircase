module Composer
  module Import
    class VirtualPath
      def initialize(path)
        @path = path
      end

      def to_s
        path
      end

      def exists?
        File.exists?(path)
      end

      private

      attr_reader :path
    end
  end
end
