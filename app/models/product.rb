class Product < ActiveRecord::Base
  # Associations
  belongs_to :brand
  has_many :categorizations
  has_many :categories, through: :categorizations
  with_options(class_name: "Product::Photo") do |product|
    product.has_many :photos, dependent: :destroy
    product.has_one :main_photo, conditions: {main_photo: true}
    product.has_many :additional_photos, conditions: {main_photo: false}
  end

  has_one  :preferred_categorization, class_name: "Categorization", conditions: {preferred: true}
  has_one  :preferred_category, class_name: "Category", through: :preferred_categorization, source: :category
  has_one  :param_template, through: :preferred_category
  has_many :param_items, through: :param_template, class_name: "ParamItem"
  has_many :param_values, through: :template_param_items, class_name: "ParamValue"

  has_many :parametrizations
  has_many :parametrization_param_items,  through: :parametrizations
  has_many :parametrization_param_values, through: :parametrizations, source: :param_value

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 171}

  validates :model_name,
            presence: true,
            length: {maximum: 140}

  validates :url,
            presence: true,
            length: {maximum: 171},
            uniqueness: true

  validates :brand,
            presence: true

  validates :short_description,
            presence: true

  validates :description,
            presence: true

  validates :default_price,
            presence: true,
            numericality: {only_integer: true}

  validates :recommended_price,
            presence: true,
            numericality: {only_integer: true}

  validates :purchase_price,
            presence: true,
            numericality: {only_integer: true}

  validates :warranty,
            presence: true,
            numericality: {only_integer: true}

  validates :recycling_fee,
            presence: true,
            numericality: {only_integer: true}

  validates :vat_rate,
            presence: true,
            numericality: true

  validates :external_id,
            presence: true,
            numericality: {only_integer: true}

  def has_param_value?(param_item_name, param_value)
    self.parametrization_param_values.joins(:param_item).where(["param_items.name = ?", param_item_name]).pluck("param_values.value").include?(param_value)
  end
end
