require "csv"

module DataImport
  class SupplierId
    ID_COLUMN_REGEXP = /_sid$/

    def self.import
      data = DataFile.new.inject([]) do |ids, record|
        record.keys.find_all { |key| key.to_s =~ ID_COLUMN_REGEXP}.each do |supplier_id_key|
          next if record[supplier_id_key].nil?
          supplier = supplier_id_key.to_s.gsub(ID_COLUMN_REGEXP, "").camelcase
          ids << [
              supplier,
              record[supplier_id_key],
              record[:product_id]
          ]
        end
        ids
      end

      unless data.empty?
        ProductSupplierId.import_without_validations_or_callbacks([:supplier, :supplier_id, :product_id], data, on_duplicate_key_update: [:product_id])
      end
    end

    class DataFile
      include Enumerable

      COLUMNS = [
          :external_id,
          :price,
          :retail_price,
          :waste,
          :store_price,
          :null_price,
          :weight,
          :purchase_price,
          :watch_price,
          :auto_price,
          :dont_pay_price_search,
          :top_product,
          :fast_sid,
          :fixed_price,
          :ean_code,
          :free_shipping,
          :fast_ignore,
          :dont_sell,
          :kb_sid,
          :indesit_sid,
          :beko_sid,
          :lg_white_sid,
          :lg_brown_sid,
          :kb_ignore,
          :heureka_top3_check,
          :heureka_max_cpc,
          :amica_sid,
          :minimal_margin,
          :mixmedia_sid,
          :dont_send_for_review,
          :autoprice_on_weekend,
          :fake_price,
          :newsletter_price,
          :dimension_height,
          :dimension_width,
          :dimension_length,
          :storage_type,
          :stored,
          :price_protection
      ]

      COLUMN_SEPARATOR = ";"

      def parse_csv
        CSV.new(open(csv_file), col_sep: COLUMN_SEPARATOR)
      end

      def csv_file
        File.join(Rails.root, "tmp/import/data.csv")
      end

      def each
        csv.each do |row|
          data = {}

          COLUMNS.each_with_index do |name, index|
            data[name] = row[index]
          end

          product_id = find_product_id(data[:external_id])
          next if product_id.nil?
          data[:product_id] = product_id

          yield data
        end
      end

      def find_product_id(external_id)
        Product.where(external_id: external_id).pluck(:id).first
      end

      def csv
        @csv ||= parse_csv
      end
    end
  end
end