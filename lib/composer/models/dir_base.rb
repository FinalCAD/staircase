module Composer
  module Models
    module DirBase
      include Base

      def initialize(name, full_path)
        @name = name
        @path = full_path.gsub(name,'')
      end

      def source_path
        Import::VirtualPath.new("#{@path}/#{name}")
      end
    end
  end
end
