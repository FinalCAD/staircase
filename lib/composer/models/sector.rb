module Composer
  module Models
    class Sector
      include FileBase

      attr_reader :zones

      def initialize(name, full_path)
        super
        @zones = {}
      end

      def append_zone(zone)
        zones[zone.name] ||= zone
      end
    end
  end
end
