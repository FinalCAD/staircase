module Composer
  class Model
    include Composer::Import

    def exploded_path
      @exploded_path ||= source_path.split(File::SEPARATOR)
    end

  end
end
