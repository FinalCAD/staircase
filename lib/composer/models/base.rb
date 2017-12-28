module Composer
  module Models
    module Base
      extend ActiveSupport::Concern

      attr_reader :source_path

    end
  end
end
