require "nokogiri"

module Miners
  class Indesit < Base
    SKIP_FIRST_ROWS = 1
    BASE_WORK_SHEET = 0

    def each
      @xls.each(SKIP_FIRST_ROWS) do |record_line|
        yield Record.new(record_line)
      end
    end

    INDESIT_XLS_FILE = upload_path("indesit.xls")

    def load_resource
      @xls = parse_xls(INDESIT_XLS_FILE).worksheet(BASE_WORK_SHEET)
    end

    extracts_data :stock_availability

    class Record < Base::XLSRecord
      extract_columns do
        string  "B" => :id
        string  "C" => :name
        integer "D" => :in_stock_count
      end

      def in_stock_count=(count)
        self[:in_stock_count] = count > 0 ? count : 0
      end
    end
  end
end