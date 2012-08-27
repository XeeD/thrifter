class Product::Replacable < ActiveRecord::Base
  self.table_name = "product_replacements"

  after_destroy :change_product_state_after_destroy
  after_create  :change_product_state_after_create

  def change_product_state_after_create
    original.replace!
  end

  def change_product_state_after_destroy
    if original.replacements.size == 0
      original.revert_replace!
    end
  end

  # Associations
  with_options(class_name: "Product") do |product|
    product.belongs_to :original, foreign_key: "product_id"
    product.belongs_to :replacement, foreign_key: "replaced_by_id"
  end
end