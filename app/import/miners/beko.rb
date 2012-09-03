require 'csv'

module Miners
  class Beko < Base
    def each
      @csv.each do |record_csv|
        yield Record.new(record_csv)
      end
    end

    BEKO_CSV_FILE = upload_path("beko.csv")

    def load_resource
      @csv = parse_csv(BEKO_CSV_FILE)
    end

    extracts_data :purchase_prices, :stock_availability

    class Record < Base::CSVRecord
      extract_columns do
        string  "A" => :name
        integer "B" => :stored
        integer "C" => :price
      end

      def stored=(stored)
        raise "Need to define stored/in_stock_count logic!"
      end
    end
  end
end