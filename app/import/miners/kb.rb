require "nokogiri"

module Miners
  class KB < Base
    def each
      @xml.xpath("/zbozi/zaznam").each do |record_xml|
        yield Record.new(record_xml)
      end
    end

    KB_XML_FILE = upload_path("kb_small.xml")

    def load_resource
      @xml = parse_xml(KB_XML_FILE)
    end

    extracts_data :supplier_items

    class Record < Base::XMLRecord
      extract_xpaths do
        string  "sIdZbozi"                  => :supplier_id
        string  "sKodZbozi"                 => :code
        string  "sJmenoVyrobku"             => :name
        string  "sSkupinaVyrobku"           => :category
        string  "sKratkyPopis"              => :short_description
        string  "sPopis"                    => :description
        string  "sEan"                      => :ean
        integer "nIDVyrobce"                => :manufacturer_id
        string  "sJmenoVyrobce"             => :manufacturer_name
        integer "sZarukaMesicu"             => :warranty
        string  "nDph"                      => :vat
        string  "sJmenoObrazku"             => :image_url
        bool    "bNejprodavanejsiKategorie" => :most_sold_category
        bool    "bNejprodavanejsiEshop"     => :most_sold_eshop
        bool    "bVypnout"                  => :shut_down
      end

      # Data refinement
      def vat=(value)
        self[:vat] = value.gsub(/\./, '').to_i
      end

      # Extraction
    end
  end
end
