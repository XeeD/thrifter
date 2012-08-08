# encoding: UTF-8

module Admin
  class ProductCategorizationsController < AdminController
    before_filter :only_in_shop_context, only: [:edit_shop, :update_shop]

    def index
    end

    def edit_shop
    end

    def update_shop
      product_categorizations = ProductShopCategorizations.new(product, shop)
      product_categorizations.set_alternative_categories!(params[:product][:category_ids])
      redirect_to admin_product_categorizations_url(product)
    end


    private

    def product
      @product ||= Product.find(params[:product_id])
    end

    helper_method :product

    def categorizations
      product.categorizations
    end

    helper_method :categorizations

    def shop
      @shop ||= params[:shop_id] && Shop.find(params[:shop_id])
    end

    helper_method :shop

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