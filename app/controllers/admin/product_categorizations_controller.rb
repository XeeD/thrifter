# encoding: UTF-8

module Admin
  class ProductCategorizationsController < AdminController
    before_filter :only_in_shop_context, only: [:edit_alternative, :update_alternative]

    def index
    end

    def edit_alternative
    end

    def update_alternative
      product_categorizations = ProductShopCategorizations.new(product, shop)
      product_categorizations.set_alternative_categories!(params[:product][:category_ids])
      redirect_to admin_product_categorizations_url(product)
    end

    def edit_preferred
      unless categorization.preferred
        flash[:error] = "Chyba při zobrazení editace hlavní kategorie"
        redirect_to admin_product_categorizations_path(product)
      end
    end


    private

    # Product
    def product
      @product ||= Product.find(params[:product_id])
    end

    helper_method :product

    # Categorizations colletion
    def categorizations
      product.categorizations
    end

    helper_method :categorizations

    # Categorization - for member action
    def categorization
      categorizations.find(params[:id])
    end

    helper_method :categorization

    # Shop - if defined in params
    def shop
      @shop ||= params[:shop_id] && Shop.find(params[:shop_id])
    end

    helper_method :shop

    # Halt filter chain if shop_id is not present in params
    def only_in_shop_context
      unless shop.present?
        flash[:error] = "Musíte specifikovat obchod"
        redirect_to(admin_product_categorizations_url(product))
        false
      end
      true
    end
  end
end