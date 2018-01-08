require 'fileutils'

module Composer
  class Export

    attr_reader :registry, :export_path

    def initialize(registry=Composer::Stores::Registry)
      @registry    = registry.instance
      @export_path = 'spec/fixtures/archive/ouput'

      FileUtils::mkdir_p(export_path)
    end

    def generate
      registry.inputs.each do |_, staircase_model|
        # Convert PDF to PNG
        Processors::PdfToPng.new(self).process(staircase_model)
        # Reduce PNG Size
        Processors::PngReduce.new(self).process(staircase_model)

        # Compose Png Sector and create Sector
        # Processors::ComposeSector.new(self).process(staircase_model)
      end
    end

  end
end
