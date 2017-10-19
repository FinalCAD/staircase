module Types
  class DateType

    attr_reader :value

    def initialize(value)
      @value = value
    end

    def valid?
      return false unless (@match = value.match(regexp))
      true
    end

    def to_cell
      return unless valid?
      "#{@match[:month]}/#{@match[:day]}/#{@match[:year]}"
    end

    private

    REGEXP = /^(?<day>[0-3][0-9])\/(?<month>[0-1][0-9])\/(?<year>20[0-3][0-9])$/
    private_constant :REGEXP

    def regexp
      REGEXP
    end
  end
end
