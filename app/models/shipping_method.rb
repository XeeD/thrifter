# encoding: UTF-8

class ShippingMethod < ActiveRecord::Base
  # Macros
  acts_as_list

  # Associations
  has_many :shipments
  has_many :orders, through: :shipments
  has_many :package_sizes

  has_and_belongs_to_many :payment_methods, join_table: "shipping_method_has_payment_methods"
  has_and_belongs_to_many :shops, join_table: "shop_has_shipping_methods"

  accepts_nested_attributes_for :package_sizes, reject_if: :all_blank, allow_destroy: true

  # Scopes
  default_scope -> { order :position }

  # Validations
  validates :shops,
            presence: true

  validates :package_sizes,
            presence: true

  validates :payment_methods,
            presence: true

  validates :name,
            presence: true,
            length: {maximum: 100}

  validates :short_description,
            presence: true

  validates :description,
            presence: true

  validates :free_from,
            numericality: {only_integer: true}

  validates :caesar_type_id,
            length: {maximum: 1},
            numericality: {only_integer: true},
            presence: true

  validates :caesar_type_name,
            length: {maximum: 30},
            presence: true
end