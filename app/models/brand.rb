class Brand < ActiveRecord::Base
  has_many :products

  validates :name, length: {maximum: 30}, presence: true
  validates :url, length: {maximum: 30}, presence: true, uniqueness: true
end
