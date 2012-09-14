class CreateShippingMethodHasPaymentMethods < ActiveRecord::Migration
  def change
    create_table :shipping_method_has_payment_methods, id: false, force: true do |t|
      t.belongs_to :shipping_method
      t.belongs_to :payment_method
    end

    add_index :shipping_method_has_payment_methods, [:shipping_method_id, :payment_method_id], {unique: true, name: "shipping_method_has_payment_methods_index"}
  end
end
