class CreateProductSupplierIds < ActiveRecord::Migration
  def change
    create_table :product_supplier_ids do |t|
      t.belongs_to :product,     null: false
      t.string     :supplier,    null: false, limit: 20
      t.string     :supplier_id, null: false, limit: 20
      t.boolean    :current, default: false
    end

    add_index :product_supplier_ids, [:supplier_id, :supplier], unique: true
    add_index :product_supplier_ids, :product_id
  end
end
