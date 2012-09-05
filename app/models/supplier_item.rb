class SupplierItem < ActiveRecord::Base

  class << self
    def import_supplier_items(supplier, records)
      puts "import supplier items"
      import record_attributes, supplier_item_records_for_import(supplier, records)
    end

    private

    def supplier_item_records_for_import(supplier, records)
      records.map { |record|
        [
          record[:id],
          supplier,
          record[:name],
          record.reject {|key, value| rejected_attributes.include?(key)}
        ]
      }
    end

    def record_attributes
      [
        :supplier_id,
        :supplier,
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
