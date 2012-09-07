require "nokogiri"

module Miners
  class LgBrown < Base
    SKIP_FIRST_ROWS = 3
    BASE_WORK_SHEET = 0

    def each
      @xls.each(SKIP_FIRST_ROWS) do |record_line|
        yield Record.new(record_line)
      end
    end

    LG_WHITEN_XLS_FILE = upload_path("lg_white.xls")

    def load_resource
      @xls = parse_xls(LG_WHITE_XLS_FILE).worksheet(BASE_WORK_SHEET)
    end

    extracts_data :stock_availability

    class Record < Base::XLSRecord
      extract_columns do
        string  "B" => :id
        integer "D" => :in_stock_count
      end

      def id=(id)
        name.gsub(/\.\w+$/, '').strip
      end

      def in_stock_count=(count)
        raise "DUNNO with stock count"
      end
    end
  end
end