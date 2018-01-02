require 'shellwords'

module Composer
  module Converter
    class SectorPngReduce

      def process
        image_file
      end

      def image_file
        @image_file ||= self.class.reduce(sector_file, options)
      end

      class << self
        def reduce(sector_file, options={})
          options = options.reverse_merge(extension: 'png')

          file = Tempfile.new(%W[sector_file .#{options[:extension]}])
          cmd = [
            'convert'
          ] + options[:convert_options] + [ Shellwords.shellescape(sector_file.path), file.path ]
          run_command(cmd.join(' '))
          file
        end
      end
    end
  end
end
