require "parseexcel"

module Miners
  class Amica < Base
    SKIP_FIRST_ROWS = 1
    BASE_WORK_SHEET = 0

    def each
      @xls.each(SKIP_FIRST_ROWS) do |record_line|
        yield Record.new(record_line)
      end
    end

    AMICA_XLS_FILE = upload_path("amica.xls")

    def load_resource
      @xls = parse_xls(AMICA_XLS_FILE).worksheet(BASE_WORK_SHEET)
    end

    extracts_data :stock_availability, :supplier_items

    class Record < Base::XLSRecord
      extract_records do
        string  "B" => :id
        string  "D" => :name
        integer "E" => :in_stock_count
        string  "F" => :ean
      end

      def name=(name)
        self[:name] = name.gsub(/[^A-Za-z0-9 +.]/, '').strip
      end

      def in_stock_count=(count)
        self[:in_stock_count] = count > 0 ? count : 0
      end
    end
  end
end