class AddMainPhotoToProductPhoto < ActiveRecord::Migration
  def change
    add_column :product_photos, :main_photo, :boolean, default: false
    add_index :product_photos, :main_photo
  end
end
