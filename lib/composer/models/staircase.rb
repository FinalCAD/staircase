module Composer
  module Models
    class Staircase
      include DirBase

      attr_reader :sectors

      def initialize(name, full_path)
        super
        @sectors = {}
      end

      def append_sector(sector)
        sectors[sector.name] ||= sector
      end
    end
  end
end
