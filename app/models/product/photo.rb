class Product::Photo < ActiveRecord::Base
  # Macros
  mount_uploader :image, ProductPhotoUploader

  # Associations
  belongs_to :product

  # Validations
  validates :product,
            presence: true

  validates :title,
            length: {maximum: 100}
end
