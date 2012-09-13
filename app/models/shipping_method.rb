class ShippingMethod < ActiveRecord::Base
  has_many :shipments
  has_many :orders
  has_and_belongs_to_many :shops, join_table: "shop_has_shipping_methods"
end