class Product < ActiveRecord::Base
  # Validations
  validates :name,
            presence: true,
            length: {maximum: 301}

  validates :model_name,
            presence: true,
            length: {maximum: 150}

  validates :url,
            presence: true,
            length: {maximum: 301},
            uniqueness: true

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
