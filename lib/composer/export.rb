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
        Processors::PdfToPng.new(self).process(staircase_model)
        # Compose Png Sector and create Sector
        # Processors::ComposeGrid.new.process(staircase_model)
        # Compose Json Sector and update it
        # Assemble Zones with name changing and JSON Update
      end
    end

  end
end
