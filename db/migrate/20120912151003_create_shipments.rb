class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments, force: true do |t|
      t.integer :price

      t.belongs_to :order
      t.belongs_to :shipping_method
    end

    add_index :shipments, [:order_id, :shipping_method_id]
  end
end
