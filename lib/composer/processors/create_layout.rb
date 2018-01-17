module Composer
  module Processors
    class CreateLayout < Base

      def process(staircase_model)
        cmd = []
        cmd << "convert -size #{layout_dimension} xc:skyblue"
        file = Tempfile.new(%W[layout .png])
        cmd << file.path

        run_command(cmd.join(' '))

        copy(file, layout_path(staircase_model))

        nil
      end

    end
  end
end
