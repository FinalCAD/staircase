require 'singleton'

module Composer
  module Stores
    class Register
      include Singleton

      attr_reader :staircases

      def initialize
        @staircases = {}
      end

      def self.get
        instance
      end

      def append_staircase(staircase)
        return unless staircase.name
        staircases[staircase.name] ||= staircase
      end

    end
  end
end
