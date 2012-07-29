class Product::Photo < ActiveRecord::Base
  # Macros
  mount_uploader :image, ProductPhotoUploader

  # Associations
  belongs_to :product

  # Scopes
  default_scope -> { order("main_photo DESC") }

  # Validations
  validates :product,
            presence: true

  validates :title,
            length: {maximum: 100}

  validates :image,
            presence: true,
            on: :create

  # Callbacks
  before_save(:allow_only_one_main_photo)

  def allow_only_one_main_photo
    logger.debug "__CB__ in callback"
    logger.debug self.inspect
    if main_photo?
      self.class.where(product_id: product_id, main_photo: true).each do |photo|
        photo.main_photo = false
        logger.debug "setting #{photo.inspect} as not main"
        photo.save
      end
    end
  end
end
