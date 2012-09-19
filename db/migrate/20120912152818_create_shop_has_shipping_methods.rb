class CreateShopHasShippingMethods < ActiveRecord::Migration
  def change
    create_table :shop_has_shipping_methods, force: true do |t|
      t.belongs_to :shop
      t.belongs_to :shipping_method
    end

    add_index :shop_has_shipping_methods, [:shop_id, :shipping_method_id], {unique: true, name: "index_shop_on_shop_id_and_shipping_method_id"}
  end
end
