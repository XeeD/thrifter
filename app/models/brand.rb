class Brand < ActiveRecord::Base
  has_many :products

  validates :name, :url, length: {maximum: 100}, presence: true
  validates :url, uniqueness: true
  validates :description, presence: true
end