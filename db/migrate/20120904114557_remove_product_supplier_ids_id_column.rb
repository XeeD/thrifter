class RemoveProductSupplierIdsIdColumn < ActiveRecord::Migration
  def up
    remove_column :product_supplier_ids, :id
  end

  def down
    add_column :product_supplier_ids, :id, :integer
    add_index :product_supplier_ids, :id
  end
end
