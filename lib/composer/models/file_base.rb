module Composer
  module Models
    module FileBase
      include Base

      def initialize(name, full_path)
        @name  = File.basename(name, File.extname(name))
        @path  = full_path.gsub(name,'')
      end

      def source_path(type)
        Import::VirtualPath.new("#{@path}#{name}.#{type}")
      end

    end
  end
end
