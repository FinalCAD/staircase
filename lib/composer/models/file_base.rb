module Composer
  module Models
    module FileBase
      extend ActiveSupport::Concern

      def extension
        File.extname(model.exploded_path.last).gsub(/^\./,'')
      end

      def name
        File.basename(model.exploded_path.last, ".#{extension}")
      end

      def short_name
        File.basename(_name, ".#{extension}")
      end

      def full_name
        model.exploded_path.last
      end

      def dir_path
        File.dirname(model.source_path.gsub(root_path,'')).gsub(/^\//,'')
      end

      def full_path(ext=nil)
        ext ||= extension
        Composer::Lib::VirtualPath.new(
          [ root_path, dir_path, "#{name}.#{ext}" ].join(File::SEPARATOR)
        )
      end

      private

      def _name
        model.exploded_path.last
      end

    end
  end
end
