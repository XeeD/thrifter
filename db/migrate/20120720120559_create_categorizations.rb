class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations, force: true do |t|
      t.belongs_to :product
      t.belongs_to :category
      t.timestamps
    end

    add_index :categorizations, :product_id
    add_index :categorizations, :category_id
  end
end
