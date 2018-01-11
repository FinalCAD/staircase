module Composer
  module Converter
    class PdfToImage < Base

      def process
        image_file
      end

      def image_file
        @image_file ||= self.class.to_image(input, options)
      end

      class << self
        # imagemagick requires ghostscript to convert pdfs
        # brew install ghostscript
        def to_image(input, options={})
          options = options.reverse_merge(extension: 'png', convert_options: [])

          file = Tempfile.new(%W[input .#{options[:extension]}])
          cmd = [
              'convert',
              '-alpha opaque',
              '-flatten'
          ] + options[:convert_options] + [ Lib::SafePath.new(input.path).path.escaped, file.path ]
          puts("#{self.name} => #{cmd.join(' ')}")
          run_command(cmd.join(' '))
          file
        end

        def run_command(cmd)
          system(cmd)
        end
      end
    end
  end
end
