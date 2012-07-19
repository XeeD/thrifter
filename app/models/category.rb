# encoding: UTF-8

class Category < ActiveRecord::Base
  acts_as_nested_set

  attr_protected :lft, :rgt
  
  CATEGORY_TYPES = {"Navigační" => "navigational", "Produktová" => "product_list", "Přídavná" => "additional"}

  validates :short_name, :url, :plural_name, :category_type, presence: true
  validates :short_name, length: {maximum: 80}
  validates :url, length: {maximum: 120}
  validates :plural_name, length: {maximum: 120}
  validates :singular_name, length: {maximum: 120}
  validates :category_type, inclusion: {in: CATEGORY_TYPES.values}
end
