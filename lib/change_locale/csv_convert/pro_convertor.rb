module CsvConvert
  class ProConvertor

    def initialize(path)
      @path = path
      @data = []
    end

    def convert
      read
      puts("Path :: #{write}")
    end

    private

    def read
      count = 0
      CSV.foreach(file_path) do |row|
        count += 0
        next if count < header_size

        data << Convert.new(row)
      end
      nil
    end

    def write
      file = Tempfile.new(['foo', '.csv'])
      CSV.open(file.path, 'wb') do |csv|
        csv << headers
        CsvConvert::Pro::ArrayConvertor.new(data).to_rows.each do |row|
          csv << row
        end
      end
      file.path
    end

    attr_reader :data

    def header_size
      6
    end

    def headers
      %w(FECHA BANK_DESCRIPTION LABEL IMPORTE CREDITO IMPORTE DEBITO TIPO FACTURAS SALDO)
    end
  end
end
