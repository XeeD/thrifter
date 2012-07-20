class CreateProductHasCategories < ActiveRecord::Migration
  def change
    create_table :product_has_categories, force: true, id: false do |t|
      t.references :product, null: false
      t.references :category, null: false
    end

    add_index :product_has_categories, [:product_id, :category_id], unique: true
    add_index :product_has_categories, [:category_id, :product_id], unique: true
  end
end
