# encoding: UTF-8

module Admin
  class ProductsController < AdminController

    def index
    end

    def new
    end

    def create
      if product.save
        redirect_to admin_products_url,
                    notice: "Nový produkt #{product.name} byl vytvořen"
      else
        flash.now[:error] = "Chyba při vytváření nového produktu"
        render "new"
      end
    end

    def edit
    end

    def update
      if product.update_attributes(params[:product])
        redirect_to admin_products_url,
                    notice: "Produkt #{product.name} byl upraven"
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
      flash[:notice] = "Produkt #{product.name} byl smazán"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný produkt"
    ensure
      redirect_to admin_products_url
    end

    private

    def product
      @product ||= params[:id] ? products.find(params[:id]) : products.new(params[:product])
    end

    helper_method :product

    def products
      @products ||= Product.unscoped
    end

    helper_method :products

    def search_products
      @search_products ||= begin
        search = Product.default_admin_visible.search(params[:search])
        search.meta_sort ||= "name.asc"
        search
      end
    end

    helper_method :search_products

    def selected_products
      @selected_products ||= ProductDecorator.decorate(search_products.page(params[:page]))
    end

    helper_method :selected_products
  end
end