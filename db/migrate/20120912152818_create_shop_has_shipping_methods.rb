class CreateShopHasShippingMethods < ActiveRecord::Migration
  def change
    create_table :shop_has_payment_methods, force: true do |t|
      t.belongs_to :shop
      t.belongs_to :payment_method
    end

    add_index :shop_has_payment_methods, [:shop_id, :payment_method_id], {unique: true, name: "index_shop_on_shop_id_and_payment_method_id"}
  end
end
