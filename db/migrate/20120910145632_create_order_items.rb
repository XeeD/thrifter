class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items, force: true do |t|
      t.integer :quantity, limit: 2
      t.integer :price, limit: 3
      t.integer :waste, limit: 2

      t.boolean :sent, default: false

      t.belongs_to :order
      t.belongs_to :product
    end

    add_index :order_items, :order_id
    add_index :order_items, :product_id
  end
end
