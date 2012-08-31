require "nokogiri"

module Miners
  class KB < Base
    def each
      puts "each"
      records = @xml.xpath("/zbozi/zaznam")
      pb = ProgressBar.create(total: records.length)
      records.each do |record_xml|
        pb.increment
        yield Record.new(record_xml, {in_stock: @xml_in_stock, prices: @xml_prices})
      end
    end

    KB_XML_FILE     = upload_path("kb_products.xml")
    KB_XML_IN_STOCK = upload_path("kb_in_stock.xml")
    KB_XML_PRICES   = upload_path("kb_prices.xml")

    def load_resource
      @xml          = parse_xml(KB_XML_FILE)
      @xml_in_stock = parse_xml(KB_XML_IN_STOCK)
      @xml_prices   = parse_xml(KB_XML_PRICES)
    end

    extracts_data :supplier_items

    class Record < Base::XMLRecord
      extract_xpaths do
        string  "sKodZbozi"                 => :id
        string  "sJmenoVyrobku"             => :name
        string  "sSkupinaVyrobku"           => :category
        #string  "sKratkyPopis"              => :short_description
        string  "sPopis"                    => :description
        string  "sEan"                      => :ean
        #integer "nIDVyrobce"                => :manufacturer_id
        #string  "sJmenoVyrobce"             => :manufacturer_name
        #integer "sZarukaMesicu"             => :warranty
        #string  "nDph"                      => :vat
        #string  "sJmenoObrazku"             => :image_url
      end

      register_extractor do |record_xml|
        self[:waste] = extract_waste(record_xml)
      end

      connect_xml :in_stock do |xml, record|
        xml.at_xpath("//zaznam[sKodZbozi[normalize-space() = \"#{record[:id]}\"]]")
      end

      connect_xml :prices do |xml, record|
        xml.at_xpath("//zaznam[sKodZbozi[normalize-space() = \"#{record[:id]}\"]]")
      end

      extract_xpaths(:in_stock) do
        integer "sDostupnost"         => :in_stock_count
        string  "sDostupnostNazev"    => :in_stock_description
      end

      extract_xpaths(:prices) do
        integer "sDoporucenaCena"     => :recommended_price
        integer "sCenaWithoutRecycle" => :price
      end

      # Data refinement
      def vat=(value)
        self[:vat] = value.gsub(/\./, '').to_i
      end

      # Extraction
      def extract_waste(xml)
        waste_base = xml.xpath("/nRecyclePrice").text.to_f
        waste_vat  = xml.xpath("/nRecycleDph").text.to_f

        (waste_base * (100 + waste_vat) / 100).round
      end
    end
  end
end
