require "nokogiri"

module Miners
  class Fast < Base
    def each
      @xml.xpath("/FAST_Business_Marketplace/record").each do |record_xml|
        yield Record.new(record_xml)
      end
    end

    FAST_XML_FILE = upload_path("fast.xml")

    def load_resource
      @xml = Nokogiri::XML.parse(open(FAST_XML_FILE))
    end

    extracts_data :stock_availability, :purchase_prices, :internet_prices

    class Record < XMLRecord
      extract_xpaths do
        integer "MATNR"            => :id
        string  "ZMENGE"           => :in_stock_description
        string  "EAN11"            => :ean_code
        string  "DPH"              => :vat
        money   "PRICE"            => :purchase_price
        money   "PRICE_MO_AKCNI"   => :internet_price
        money   "PRICE_MO"         => :recommended_price
        string  "PRICE_PHE"        => :recycling_fee
        string  "TITLE"            => :category
        string  "PATH_LIM"         => :image_url
        string  "ZVYP"             => :sale_flag
      end

      register_extractor do |record_xml|
        self[:name] = extract_name(record_xml)
      end

      # Data refinement
      def in_stock_description=(description)
        description_range = case description
                              when "1 - 5" then
                                1..5
                              when "5 - 10" then
                                5..10
                              when "> 10" then
                                10..(1.0/0) # Infinity
                              else
                                0
                            end
        self[:in_stock_description] = description_range
        self[:in_stock_count] = description_range.is_a?(Range) ? description_range.first : description_range
      end

      def vat=(value)
        self[:vat] = value.gsub(/%$/, '').to_i
      end

      def recycling_fee=(value)
        self[:recycling_fee] = (value.gsub(/,/, '.').to_f * (100 + self[:vat]) / 100.0).round
      end

      # Extraction
      def extract_name(xml)
        brand = xml.xpath("/ZNACKA").text
        model_name = xml.xpath("/TEXT").text.gsub(/ {2,}(.+ )+$/, '')

        "#{brand.strip} #{model_name.strip}"
      end

      def extract_price(price_str)
        price_str.gsub(/,/, '.').to_f.ceil
      end

      def valid
        !(sale_flag == "X" and stock_count == "0")
      end
    end
  end
end
