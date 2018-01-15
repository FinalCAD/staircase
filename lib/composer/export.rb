require 'fileutils'

module Composer
  class Export

    attr_reader :context

    def initialize(registry: Composer::Stores::Registry, context: {})
      @registry    = registry.instance
      @context     = context.reverse_merge(export_path: 'spec/fixtures/archive/output')

      FileUtils::mkdir_p(@context[:export_path])
    end

    def generate

      registry.inputs.each do |_, staircase_model|
        # Convert PDF to PNG
        Processors::PdfToPng.new(context).process(staircase_model)
        # Reduce PNG Size
        Processors::CreateLayout.new(context).process(staircase_model)
        # Assemble PNG
        Processors::ComposeGrid.new(context).process(staircase_model)
        # Annotate PNG
        Processors::Annotate.new(context).process(staircase_model)
        # Move Zone into the target place
        Processors::MoveZone.new(context).process(staircase_model)
        # Set metadata for a Staircase based on his sectors
        Processors::Metadata::Sector.new(context).process(staircase_model)
        # Set the new metadata for a Zone based on the created Staircase
        Processors::Metadata::Zone.new(context).process(staircase_model)

        break
      end
    end

    private

    attr_reader :registry

  end
end
