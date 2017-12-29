module Composer
  module Models
    module Base
      extend ActiveSupport::Concern

      attr_reader :path, :name

    end
  end
end
