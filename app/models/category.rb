# encoding: UTF-8

class Category < ActiveRecord::Base
  # Macros
  acts_as_nested_set

  # Associations
  has_many :categorizations
  has_many :products, through: :categorizations

  belongs_to :param_template
  belongs_to :parent_category, foreign_key: :parent_id, class_name: "Category"

  # Attributes
  attr_accessible :short_name, :url, :plural_name, :singular_name, :category_type, :parent_id

  # Enumerations
  CATEGORY_TYPES = {
      "Navigační"  => "navigational",
      "Produktová" => "product_list",
      "Přídavná"   => "additional"
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
            inclusion: {in: CATEGORY_TYPES.values},
            parent_field_combination: {
                :navigational => [:navigational, :product_list, :additional],
                :product_list => [:additional],
                :additional   => [:additional]
            }

  validates :parent_id,
            parent_loop: true

  def validate
    # category_parent cannot be the same category
    fail parent_id.inspect
    if parent_id == id
      errors.add(:parent_id, "nemůže být shodná s danou kategorií")
    end
  end

  def is_product_list?
    true if category_type == CATEGORY_TYPES.fetch("Produktová")
  end
end