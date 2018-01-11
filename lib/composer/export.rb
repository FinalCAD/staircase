require 'fileutils'

module Composer
  class Export

    attr_reader :context

    def initialize(registry: Composer::Stores::Registry, context: {})
      @registry    = registry.instance
      @context     = context.reverse_merge(export_path: 'spec/fixtures/archive/output')

      FileUtils::mkdir_p(export_path)
    end

    def generate

      registry.inputs.each do |_, staircase_model|
        # Convert PDF to PNG
        Processors::PdfToPng.new(context).process(staircase_model)
        # Reduce PNG Size
        Processors::CreateLayout.new(context).process(staircase_model)
        # Assemble PNG
        Composer::Processors::ComposeGrid.new(context).process(staircase_model)
        # Annotate PNG
        Composer::Processors::Annotate.new(context).process(staircase_model)

        break
      end
    end

    private

    attr_reader :registry

  end
end
