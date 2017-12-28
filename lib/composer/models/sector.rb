module Composer
  module Models
    class Sector
      include Base

      attr_reader :name, :zones

      def initialize(name, path)
        @name        = File.basename(name, File.extname(name))
        @source_path = path.gsub(name,'')
        @types       = {}
        @zones       = {}
      end

      def path(type)
        Import::VirtualPath.new("#{@source_path}#{name}.#{type}")
      end

      def append_zone(zone)
        zones[zone.name] ||= zone
      end
    end
  end
end
