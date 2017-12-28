module Composer
  class Export

    attr_reader :registry

    def initialize(registry=Composer::Stores::Register)
      @registry = registry.instance
    end

    def generate
      registry.staircases.each do |_, staircase_model|
        Processors::PdfToPng.new.process(staircase_model)
      end
    end

  end
end
