class Shop < ActiveRecord::Base
  # Associations
  has_many :categories

  # Attributes
  attr_accessible :host, :name, :short_name

  # Validations
  validates :host,
            presence: true,
            length: {maximum: 20, minimum: 3},
            uniqueness: true

  validates :name,
            presence: true,
            length: {maximum: 20},
            uniqueness: true

  validates :short_name,
            presence: true,
            length: {maximum: 20},
            uniqueness: true

end
