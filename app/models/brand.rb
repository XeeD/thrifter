class Brand < ActiveRecord::Base
  # Associations
  has_many :products

  transliterate_permalink :url

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 30}

  validates :url,
            presence: true,
            length: {maximum: 30},
            uniqueness: true
end
