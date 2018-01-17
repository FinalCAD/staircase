module Composer
  class Configuration
    attr_accessor :layout

    def initialize
      @layout = {
        dimension: { width: 2109.0, height: 1818.0 },
        marge:     { width: 40.0,   height: 8.0    },
        footer:    32.0,
        pointsize: 32.0
      }
    end
  end
end
