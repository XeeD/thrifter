class Product::Photo < ActiveRecord::Base
  mount_uploader :image, ProductPhotoUploader
end
