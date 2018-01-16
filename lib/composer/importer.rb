module Composer
  class Importer

    def initialize(source_path: 'spec/fixtures/archive/input', model: Composer::Model, context: {})
      @directory   = Composer::Import::Dir.new(source_path, model, context)
      @instantiate = Composer::Import::Instantiate.new
      @context     = context
    end

    def load
      loop do
        break unless (model = directory.next(context))
        next if model.skip?
        instantiate.call(model) # Dispatch and Instantiate appropriate models
      end
    end

    private

    attr_reader :directory, :instantiate, :context
  end
end
