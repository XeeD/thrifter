class SupplierItem < ActiveRecord::Base

  class << self
    def import_supplier_items(records)
      import record_attributes, supplier_item_records_for_import(records)
    end

    private

    def supplier_item_records_for_import(records)
      records.map { |record|
        [
          record[:supplier_id],
          record[:name],
          record
        ]
      }
    end

    def record_attributes
      [
        :supplier_id,
        :product_name,
        :record_attributes
      ]
    end
  end
end
