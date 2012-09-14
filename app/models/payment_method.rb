class PaymentMethod < ActiveRecord::Base
  has_many :payments
  has_many :orders

  has_and_belongs_to_many :shipping_methods, join_table: "shipping_method_has_payment_methods"
  has_and_belongs_to_many :shops, join_table: "shop_has_payment_methods"
end