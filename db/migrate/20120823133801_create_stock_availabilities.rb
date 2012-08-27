class CreateStockAvailabilities < ActiveRecord::Migration
  def change
    create_table :stock_availabilities do |t|
      t.integer :product_id,          null: false
      t.string  :supplier,            null: false
      t.integer :in_stock_count,      null: false
      t.string  :in_stock_description, null: false

      t.datetime :created_at,         null: false
    end

    add_index :stock_availabilities, :product_id
    add_index :stock_availabilities, :supplier
  end
end
