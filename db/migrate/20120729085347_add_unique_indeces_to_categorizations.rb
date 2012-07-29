class AddUniqueIndecesToCategorizations < ActiveRecord::Migration
  def change
    add_index :categorizations, [:category_id, :product_id], unique: true
    add_index :categorizations, [:product_id, :category_id], unique: true
  end
end
