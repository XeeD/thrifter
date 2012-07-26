class Product < ActiveRecord::Base
  # Associations
  belongs_to :brand
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :photos, class_name: "Product::Photo", dependent: :destroy

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
end
