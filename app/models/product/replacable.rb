class Product::Replacable < ActiveRecord::Base
  self.table_name = "product_replacements"

  # Associations
  with_options(class_name: "Product") do |product|
    product.belongs_to :original, foreign_key: "product_id"
    product.belongs_to :replacement, foreign_key: "replaced_by_id"
  end
end