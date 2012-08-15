class Product::Replacable < ActiveRecord::Base
  set_table_name "product_replacements"

  # Associations
  belongs_to :original, class_name: "Product", foreign_key: "product_id"
  belongs_to :replacement, class_name: "Product", foreign_key: "replaced_by_id"
end