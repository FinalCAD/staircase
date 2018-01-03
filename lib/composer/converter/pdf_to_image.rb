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
          ] + options[:convert_options] + [ Shellwords.shellescape(input.path), file.path ]
          system(cmd.join(' '))
          file
        end
      end
    end
  end
end
