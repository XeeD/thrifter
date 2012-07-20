# encoding: UTF-8

class Category < ActiveRecord::Base
  acts_as_nested_set

  has_and_belongs_to_many :products, join_table: :product_has_categories

  attr_accessible :short_name, :url, :plural_name, :singular_name, :category_type

  CATEGORY_TYPES = {
      "Navigační" => "navigational",
      "Produktová" => "product_list",
      "Přídavná" => "additional"
  }

  # Validations
  validates :short_name,
            presence: true,
            length: {maximum: 80}

  validates :url,
            presence: true,
            length: {maximum: 120}

  validates :plural_name,
            presence: true,
            length: {maximum: 120}

  validates :singular_name,
            length: {maximum: 120}

  validates :category_type,
            presence: true,
            inclusion: {in: CATEGORY_TYPES.values}
end