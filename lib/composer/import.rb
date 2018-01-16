module Composer
  module Import
    extend ActiveSupport::Concern

    attr_reader :context, :source_path, :index

    def initialize(path, options={})
      @source_path, @context = path, options.reverse_merge(export_path: 'spec/fixtures/archive/output')
      @index, @previous      = options[:index], options[:previous].try(:dup)
    end

    def skip?
      false
    end

    class_methods do
      def next(path, context={}, previous=nil)
        return if path.end?

        path.read_path
        new(path.current_path, index: path.index, context: context, previous: previous)
      end
    end
  end
end
