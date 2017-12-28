require 'shellwords'

module Composer
  module Converter
    class PdfToImage < Base
      alias_method :pdf_file, :input

      def process
        image_file
      end

      def image_file
        @image_file ||= self.class.to_image(pdf_file, options)
      end

      class << self
        # imagemagick requires ghostscript to convert pdfs
        # brew install ghostscript
        def to_image(pdf_file, options={})
          options = options.reverse_merge(extension: 'png', convert_options: [])

          file = Tempfile.new(%W[pdf_to_image .#{options[:extension]}])
          cmd = [
              'convert',
              '-alpha opaque',
              '-flatten'
          ] + options[:convert_options] + [ Shellwords.shellescape(pdf_file.path), file.path ]
          run_command(cmd.join(' '))
          file
        end

        def run_command(cmd)
          `#{cmd}`
        end
      end
    end
  end
end
