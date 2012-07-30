class Product::Photo < ActiveRecord::Base
  # Macros
  mount_uploader :image, ProductPhotoUploader
  acts_as_list scope: 'product_id = #{product_id} && main_photo = #{main_photo}'

  # Associations
  belongs_to :product

  # Scopes
  default_scope -> { order("main_photo DESC, position") }

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
    if main_photo?
      self.class.update_all({main_photo: false}, {product_id: product_id, main_photo: true})
    end
  end
end
