class Product::Replacable < ActiveRecord::Base
  self.table_name = "product_replacements"

  after_destroy :change_product_state
  after_create  :change_product_state

  def change_product_state
    unless original.replacements.size > 0
      original.revert_replace
    else
      original.replace
    end
  end

  # Associations
  with_options(class_name: "Product") do |product|
    product.belongs_to :original, foreign_key: "product_id"
    product.belongs_to :replacement, foreign_key: "replaced_by_id"
  end
end