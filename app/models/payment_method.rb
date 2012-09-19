class PaymentMethod < ActiveRecord::Base
  has_many :payments
  has_many :orders, through: :payments

  has_and_belongs_to_many :shipping_methods, join_table: "shipping_method_has_payment_methods"
  has_and_belongs_to_many :shops, join_table: "shop_has_payment_methods"

  validates :name,
            presence: true,
            length: {maximum: 100}

  validates :short_description,
            presence: true

  validates :description,
            presence: true

  validates :shops,
            presence: true
end