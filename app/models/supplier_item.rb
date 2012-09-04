class SupplierItem < ActiveRecord::Base

  class << self
    def import_supplier_items(records)
      raise supplier_item_records_for_import(records).to_s
      import record_attributes, supplier_item_records_for_import(records)
    end

    private

    def supplier_item_records_for_import(records)
      records.map { |record|
        [
          record[:id],
          record[:name],
          record.reject! {|key, value| rejected_attributes.include?(key)}
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

    def rejected_attributes
      [
        :id,
        :name,
        :in_stock_count
      ]
    end
  end
end
