class AddProductIdToProductPhoto < ActiveRecord::Migration
  def change
    add_column :product_photos, :product_id, :integer
    add_index :product_photos, :product_id
  end
end
