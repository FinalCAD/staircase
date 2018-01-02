module Composer
  module Models
    module Import
      module Base
        extend ActiveSupport::Concern

        def initialize(model)
          @model = model
        end

        included do
          attr_reader :model
        end

        def skip?
          !model.source_path.match(/Staircases/)
        end

        def root_path
          model.exploded_path[0..(index_base-1)].join(File::SEPARATOR)
        end

        def source_path
          model.source_path
        end

        private

        def index_base
          model.exploded_path.index('Staircases')
        end

        def staircase_index
          @staircase_index ||= index_base + 1
        end

      end
    end
  end
end
