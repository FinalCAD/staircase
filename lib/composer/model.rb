module Composer
  class Model
    include Composer::Import

    def staircase_name
      exploded_path[ staircase_index ]
    end

    def exploded_path
      @exploded_path ||= source_path.split(File::SEPARATOR)
    end

    def index_base
      exploded_path.index('Staircases')
    end

    def staircase_index
      @staircase_index ||= index_base + 1
    end
  end
end
