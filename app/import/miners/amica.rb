require "parseexcel"

module Miners
  class Amica < Base
    SKIP_TO_ROW = 1
    WORK_SHEET  = 0

    def each
      @xls.each(SKIP_TO_ROW) do |record_line|
        yield Record.new
      end
    end

    AMICA_XLS_FILE = upload_path("amica.xls")

    def load_resource
      @xls = parse_xls(AMICA_XLS_FILE).worksheet(WORK_SHEET)
    end

    extracts_data :stock_availability

    class Record < Base::XLSRecord
      extract_columns do
        string  2 => :id
        string  3 => :name
        integer 5 => :in_stock_count
      end
    end
  end
end