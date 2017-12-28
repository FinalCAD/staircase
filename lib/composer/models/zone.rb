module Composer
  module Models
    class Zone
      include Base

      attr_reader :name

      def initialize(name, path)
        @name        = File.basename(name, File.extname(name))
        @source_path = path.gsub(name,'')
        @types       = {}
      end

      def path(type)
        Import::VirtualPath.new("#{@source_path}#{name}.#{type}")
      end
    end
  end
end
