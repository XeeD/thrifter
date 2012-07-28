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

  # Callbacks
  before_save(:allow_only_one_main_photo)

  def allow_only_one_main_photo
    if main_photo?
      self.class.where(product_id: product_id, main_photo: true).each do |photo|
        photo.main_photo = false
        photo.save
      end
    end
  end
end
