module Miners
  class Base
    # class methods
    class << self
      attr_accessor :contains_data

      def extracts_data(*available_data)
        self.contains_data = available_data
      end

      def upload_path(filename)
        File.join(Rails.root, "tmp/import/uploads", filename)
      end
    end

    # instance methods
    def initialize
      load_resource
    end

    def records
      @records ||= []
    end

    def mine_data
      @data_mined = true
      each do |record|
        records << record.data
      end
    end

    def data_mined?
      defined?(@data_mined) ? @data_mined : false
    end

    def parse_xml(xml_file)
      Nokogiri::XML.parse(open(xml_file))
    end

    def parse_xls(xls_file)
      Spreadsheet::ParseExcel.parse(xls_file)
    end

    def supplier
      self.class.name.demodulize
    end

    def save
      mine_data unless data_mined?
      self.class.contains_data.each do |data_package|
        send("save_#{data_package}")
      end
    end

    def save_stock_availability
      StockAvailability.import_stock_availability(supplier, records)
    end

    def save_purchase_prices
    end

    def save_internet_prices
    end

    def save_supplier_items
      SupplierItem.import_supplier_items(records)
    end
  end
end
