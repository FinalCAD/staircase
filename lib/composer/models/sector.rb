module Composer
  module Models
    class Sector
      include Base
      include FileBase

      attr_reader :zones

      def initialize(model)
        super
        @zones = {}
      end

      def append_zone(zone)
        zones[zone.name] ||= zone
      end
    end
  end
end
