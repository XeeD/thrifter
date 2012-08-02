# encoding: UTF-8

module Admin
  class CategoriesController < AdminController

    def choose_shop
    end

    def new
    end

    def create
      if category.save
        redirect_to admin_shop_categories_url, :notice => "Kategorie #{category.plural_name} byla vytvořena"
      else
        flash.now[:error] = "Chyba při vytváření nové kategorie"
        render "new"
      end
    end

    def edit
    end

    def update
      if category.update_attributes(params[:category])
        redirect_to admin_shop_categories_url(shop), :notice => "Kategorie #{category.plural_name} byla upravena"
      else
        flash.now[:error] = "Chyba při ukládání kategorie"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít danou kategorii"
      redirect_to admin_shop_categories_url(shop)
    end

    def destroy
      category.destroy
      flash[:notice] = "Kategorie #{category.plural_name} byla smazána"
    rescue
      flash[:error] = "Nelze najít danou kategorii"
    ensure
      redirect_to admin_shop_categories_url(shop)
    end

    private

    def shop
      @shop ||= Shop.find(params[:shop_id])
    end

    helper_method :shop

    def category
      @category ||= params[:id] ? categories.find(params[:id]) : categories.new(params[:category])
    end

    helper_method :category

    def categories
      @categories ||= shop.categories
    end

    helper_method :categories
  end
end