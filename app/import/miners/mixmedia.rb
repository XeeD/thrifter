require "nokogiri"

module Miners
  class Mixmedia < Base
    def each
      @xml.xpath("/stan_agd_market/product").each do |record_xml|
        yield Record.new(record_xml)
      end
    end

    MIXMEDIA_XML_FILE = upload_path("mixmedia.xml")

    def load_resource
      @xml = parse_xml(MIXMEDIA_XML_FILE)
    end

    extracts_data :stock_availability, :purchase_prices, :internet_prices, :supplier_items

    class Record < Base::XMLRecord
      extract_xpaths do
        string  "ean"         => :id
        string  "productName" => :name
        integer "magazyn"     => :in_store_count
        string  "ean"         => :ean
        money   "price"       => :price
      end
    end
  end
end
