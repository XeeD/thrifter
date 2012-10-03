class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments, force: true do |t|
      t.integer :price, null: false

      t.belongs_to :order, null: false
      t.belongs_to :shipping_method, null: false
    end

    add_index :shipments, [:order_id, :shipping_method_id]
  end
end
