# Public: Give an escaped path for Imagemagick
#
module Composer
  module Lib
    class SafePath

      def initialize(path)
        @_path = path
      end

      def path
        @_path.to_s.gsub(/ /,'\ ')
      end

    end
  end
end
