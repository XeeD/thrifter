# encoding: UTF-8

module Admin
  class ProductPhotosController < AdminController
    def index
    end

    def create
      if product_photo.save
        redirect_to admin_product_photos_url(product),
                    notice: "Nový obrázek byl přidán produktu #{product.name}"
      else
        flash.now[:error] = "Chyba při ukládání nového produktu"
        render "index"
      end
    end

    def edit
    end

    def update
      if product_photo.update_attributes(params[:product_photo])
        redirect_to admin_product_photos_url(product),
                    notice: "Obrázek byl uložen"
      else
        flash.now[:error] = "Chyba při editaci obrázku"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný obrázek"
      redirect_to admin_product_photos_url(product)
    end

    def destroy
      product_photo.destroy
      flash[:notice] = "Obrázek produktu byl smazán"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný obrázek produktu"
    ensure
      redirect_to admin_product_photos_url(product)
    end
    
    def sort
      params[:product_photo].each_with_index do |id, index|
        Product::Photo.update_all({position: index+1}, {id: id, product_id: product.id})
      end
      render nothing: true
    end


    private

    def product
      @product ||= Product.find(params[:product_id])
    end

    helper_method :product

    def product_photos
      @photos ||= product.photos
    end

    helper_method :product_photos

    def product_photo
      @photo ||= params[:id] ? product_photos.find(params[:id]) : product_photos.new(params[:product_photo])
    end

    helper_method :product_photo
  end
end