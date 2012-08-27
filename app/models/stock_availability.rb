class StockAvailability < ActiveRecord::Base

  class << self
    def import_stock_availability(supplier, records)
      records_in_stock = records.reject { |record|
        record[:in_stock_count].to_i == 0
      }

      import record_attributes, supplier_records_for_insert(supplier, records_in_stock)
    end

    private

    # Return array of arrays that contain attributes. This array
    # can be used to bulk import all records to database at once.
    # The returned array does not contain records that have ids
    # that are not in product_supplier_ids table.
    def supplier_records_for_insert(supplier, records)
      records.map { |record|
        [
          product_id(supplier, record[:id]),
          supplier,
          record[:in_stock_count],
          record[:in_stock_description]
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
          :in_stock_count,
          :in_stock_description
      ]
    end
  end
end
