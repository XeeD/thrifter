class CreateSupplierItems < ActiveRecord::Migration
  def change
    create_table :supplier_items do |t|
      t.string :supplier_id, null: false, limit: 20
      t.string :product_name, null: false, limit: 50
      t.text   :record_attributes, null: false
    end

    add_index :supplier_items, :supplier_id
    add_index :supplier_items, :product_name
  end
end
