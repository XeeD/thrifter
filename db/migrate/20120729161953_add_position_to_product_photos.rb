class AddPositionToProductPhotos < ActiveRecord::Migration
  def change
    add_column :product_photos, :position, :integer
    add_index :product_photos, [:product_id, :position]
  end
end
