class Product < ActiveRecord::Base
  validates :name, :model_name, :url, :short_description, :description,
            :default_price, :recommended_price, :purchase_price,
            :warranty, :recycling_fee, :vat_rate, :external_id,
            presence: true
  validates :default_price, :recommended_price, :purchase_price, :warranty,
            :recycling_fee, :vat_rate, :external_id,
            numericality: {only_integer: true}
  validates :name,       length: {maximum: 301}
  validates :model_name, length: {maximum: 150}
  validates :url,        length: {maximum: 301}, uniqueness: true
end
