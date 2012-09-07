#require 'csv'
#
#module Miners
#  class Beko < Base
#    def each
#      @csv.each do |record_csv|
#        yield Record.new(record_csv)
#      end
#    end
#
#    BEKO_CSV_FILE = upload_path("beko.csv")
#
#    def load_resource
#      @csv = parse_csv(BEKO_CSV_FILE)
#    end
#
#    extracts_data :supplier_items
#
#    class Record < Base::CSVRecord
#      extract_columns do
#        string "A" => :id
#        string "A" => :name
#        string "B" => :in_stock
#        money  "C" => :price
#      end
#    end
#  end
#end