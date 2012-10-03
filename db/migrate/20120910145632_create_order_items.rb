class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items, force: true do |t|
      t.integer :quantity, limit: 2, null: false
      t.integer :price, limit: 3, null: false
      t.integer :recycling_fee, limit: 2, null: false

      t.boolean :sent, default: false

      t.belongs_to :order, null: false
      t.belongs_to :purchasable, null: false
    end

    add_index :order_items, :order_id
    add_index :order_items, :purchasable_id
  end
end
