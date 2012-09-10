class AddPositionToProductPhotos < ActiveRecord::Migration
  def change
    add_column :product_photos, :position, :integer, limit: 2
    add_index :product_photos, [:product_id, :position]
  end
end
