# encoding: UTF-8

module Admin
  class ProductsController < AdminController

    def new
    end

    def create
      if product.save
        redirect_to admin_products_url,
                    :notice => "Nový produkt #{product.name} byl vytvořen"
      else
        flash.now[:error] = "Chyba při vytváření nového produktu"
        render "new"
      end
    end

    def edit
    end

    def update
      if product.update_attributes(params[:product])
        redirect_to admin_products_url
      else
        flash.now[:error] = "Chyba při ukládání produktu"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný produkt"
      redirect_to admin_products_url
    end

    def destroy
      product.destroy
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný produkt"
    ensure
          redirect_to admin_products_url
    end

    private

    def product
      @product ||= params[:id] ? Product.find(params[:id]) : Product.new(params[:product])
    end

    helper_method :product
  end
end