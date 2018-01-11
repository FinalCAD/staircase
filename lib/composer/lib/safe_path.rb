# Public: Give an escaped path for Imagemagick
#
module Composer
  module Lib
    class SafePath

      def initialize(path)
        @_path = path
      end

      def path
        self
      end

      def escaped
        to_s.gsub(/ /,'\ ')
      end

      def to_s
        @_path.to_s
      end

    end
  end
end
