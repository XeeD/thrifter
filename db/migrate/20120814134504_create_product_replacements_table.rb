class CreateProductReplacementsTable < ActiveRecord::Migration
  def change
    create_table :product_replacements, force: true do |t|
      t.belongs_to :product
      t.belongs_to :replaced_by
    end

    add_index :product_replacements, [:product_id, :replaced_by_id]
  end
end
