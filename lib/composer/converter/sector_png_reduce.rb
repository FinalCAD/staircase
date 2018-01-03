module Composer
  module Converter
    class SectorPngReduce < Base

      def process
        image_file
      end

      def image_file
        @image_file ||= self.class.reduce(input, options)
      end

      class << self
        def reduce(input, options)
          options = options.reverse_merge(extension: 'png', convert_options: [])

          file = Tempfile.new(%W[input .#{options[:extension]}])
          cmd = [
            'convert'
          ] + options[:convert_options] + [ Shellwords.shellescape(input.path), file.path ]
          system(cmd.join(' '))
          file
        end
      end
    end
  end
end
