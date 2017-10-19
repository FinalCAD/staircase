module Types
  class CurrencyType

    attr_reader :value

    def initialize(value)
      @value = value
    end

    def valid?
      return false unless value.match(regexp)
      true
    end

    def to_cell
      return unless valid?
      v = value.gsub('.','<') if value.match(/\.+/)
      v = (v || value).gsub(',','>')
      v = v.gsub('<',',') if v.match(/\</)
      v = v.gsub('>','.')
      if value.match(/-/)
        "-€#{v.gsub('-','')}"
      else
        "€#{v}"
      end
    end

    private

    REGEXP = /,+/
    private_constant :REGEXP

    def regexp
      REGEXP
    end
  end
end
