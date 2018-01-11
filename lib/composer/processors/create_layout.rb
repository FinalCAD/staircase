module Composer
  module Processors
    class CreateLayout < Base

      def process(staircase_model)
        super

        set_convert_options(layout_dimension)
        copy(_process, layout_path(staircase_model))

        nil
      end

      private

      def _process
        options = {}.reverse_merge(extension: 'png', convert_options: @options)

        file = Tempfile.new(%W[layout .#{options[:extension]}])
        cmd = [
          'convert'
        ] + options[:convert_options] + [ file.path ]
        run_command(cmd.join(' '))
        file
      end

      def set_convert_options(layout_dimension)
        @options = [ "-size #{layout_dimension} xc:skyblue" ]
      end

      def converter
        @converter ||= 'Composer::Converter::Convert'
      end

      def convert_options
        @options
      end

    end
  end
end
