class ShippingMethod < ActiveRecord::Base
  has_many :shipments
  has_many :orders, through: :shipments
  has_many :package_sizes

  has_and_belongs_to_many :shops, join_table: "shop_has_shipping_methods"

  accepts_nested_attributes_for :package_sizes, reject_if: :all_blank, allow_destroy: true

  validates :shops,
            presence: true

  validates :package_sizes,
            presence: true

  validates :name,
            presence: true,
            length: {maximum: 100}

  validates :short_description,
            presence: true

  validates :description,
            presence: true
end