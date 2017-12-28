module Composer
  module Models
    class Staircase
      include Base

      attr_reader :name, :sectors

      def initialize(name, path)
        @name        = name
        @source_path = path.gsub(name,'')
        @types       = {}
        @sectors     = {}
      end

      def path
        Import::VirtualPath.new("#{@source_path}/#{name}")
      end

      def append_sector(sector)
        sectors[sector.name] ||= sector
      end
    end
  end
end
