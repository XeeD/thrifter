class AddSupplierToSupplierItems < ActiveRecord::Migration
  def change
    add_column :supplier_items, :supplier, :string, null: false, limit: 20
    add_index :supplier_items, [:supplier_id, :supplier], unique: true
  end
end
