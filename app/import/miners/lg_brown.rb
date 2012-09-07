#require "nokogiri"
#
#module Miners
#  class LgBrown < Base
#    SKIP_FIRST_ROWS = 1
#    BASE_WORK_SHEET = 0
#
#    def each
#      @xls.each(SKIP_FIRST_ROWS) do |record_line|
#        yield Record.new(record_line)
#      end
#    end
#
#    LG_BROWN_XLS_FILE = upload_path("lg_brown.xls")
#
#    def load_resource
#      @xls = parse_xls(LG_BROWN_XLS_FILE).worksheet(BASE_WORK_SHEET)
#    end
#
#    extracts_data :stock_availability
#
#    class Record < Base::XLSRecord
#      extract_columns do
#        string  "C" => :id
#        integer "D" => :in_stock_count
#        #money   "I" => :price
#      end
#
#      def in_stock_count=(count)
#        self[:in_stock_count] = count > 0 ? count : 0
#      end
#    end
#  end
#end