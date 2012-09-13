class PackageSize < ActiveRecord::Base
  belongs_to :shipping_method

  validates :weight_min,
            presence: true,
            numericality: {greater_or_equal_to: 0}

  validates :weight_max,
            presence: true,
            numericality: {greater_than: 0}

  validates :price,
            presence: true
end