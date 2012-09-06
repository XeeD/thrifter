class PurchasePrice < ActiveRecord::Base

  class << self
    def import_purchase_prices(supplier, records)
      puts "import purchase prices"

      import record_attributes, supplier_records_for_insert(supplier, records)
    end

    private

    def supplier_records_for_insert(supplier, records)
      records.map { |record|
        [
            product_id(supplier, record[:id]),
            supplier,
            record[:price],
        ]
      }.reject { |record| record[0].nil? }
    end

    def product_id(supplier, supplier_id)
      ProductSupplierId.where(supplier: supplier, supplier_id: supplier_id).pluck(:product_id).first
    end

    def record_attributes
      [
          :product_id,
          :supplier,
          :price
      ]
    end
  end
end