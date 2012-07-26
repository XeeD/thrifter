class CreateProductPhotos < ActiveRecord::Migration
  def change
    create_table :product_photos do |t|
      t.string :title, limit: 100
      t.string :image

      t.timestamps
    end
  end
end
