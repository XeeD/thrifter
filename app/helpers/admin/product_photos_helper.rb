module Admin
  module ProductPhotosHelper
    def product_photo_path_for_form(product, product_photo)
      if product_photo.new_record?
        admin_product_photos_path(product)
      else
        admin_product_photo_path(product, product_photo)
      end
    end

    def semantic_form_for_product_photo(product, product_photo, &block)
      path = product_photo_path_for_form(product, product_photo)
      semantic_form_for([:admin, product, product_photo], url: path, &block)
    end
  end
end