class Product < ActiveRecord::Base
  # Associations
  belongs_to :brand

  transliterate_permalink :url

  # Categories through categorizations
  # - categories, that are "main" in given shop are called "preferred"
  # - remaining categoires are called "alternative"
  has_many :categorizations
  has_many :categories, through: :categorizations

  # Categorizations - join table for sample preferred & alternative categories assigned to product
  with_options(class_name: "Categorization") do |product|
    product.has_one :sample_preferred_categorization, conditions: {preferred: true}
    product.has_many :alternative_categorizations, conditions: {preferred: false}
  end

  # Categories - sample preferred & alternative categories
  with_options(class_name: "Category", source: :category) do |product|
    product.has_one :sample_preferred_category, through: :sample_preferred_categorization
    product.has_many :alternative_categories, through: :alternative_categorizations
  end

  # Photos
  with_options(class_name: "Product::Photo") do |product|
    product.has_many :photos, dependent: :destroy
    product.has_one :main_photo, conditions: {main_photo: true}
    product.has_many :additional_photos, conditions: {main_photo: false}
  end

  # Replacements
  has_many :replacables
  has_many :replacements, through: :replacables

  # Defined params of product
  has_many :parametrizations
  has_many :defined_param_items, through: :parametrizations, source: :param_item
  has_many :defined_param_values, through: :parametrizations, source: :param_value

  # Attributes
  def param_template
    sample_preferred_category.assigned_param_template
  end

  # Get values (value column of ParamValue) for given param_item_id
  # The method uses defined_param_values scope.
  def param_values_for(param_item_id)
    defined_param_values.
        joins(:param_item).
        where(param_items: {id: param_item_id}).
        pluck("param_values.value")
  end

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

  state_machine :state, initial: :new do

    event :replace do
      transition [:visible] => :replaced
    end

    event :revert_replace do
      transition [:replaced] => :visible
    end

    event :approve do
      transition [:new, :rejected] => :visible
    end

    event :reject do
      transition [:new, :rejected] => :rejected
    end

    event :remove do
      transition [:replaced, :visible, :rejected] => :removed
    end

    event :revert_remove do
      transition [:removed] => :visible
    end

    #state :replaced do
    #  validates :replacements, presence: true
    #end

    #before_transition :to => 'replaced' do |product|
    #  ...
    #end

    #after_transition :to => 'replaced', :do => replace!
  end
end
