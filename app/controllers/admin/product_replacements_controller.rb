# encoding: UTF-8

module Admin
  class ProductReplacementsController < AdminController
    before_filter :allow_only_visible_and_replaced

    def index
    end

    def create
      params[:product][:replacement_ids].each do |replacement_id|
        product.replacables.create!(replaced_by_id: replacement_id)
      end

      redirect_to admin_product_replacements_url(product), :notice => "Produkt #{product.name} byl nahrazen"
    end

    def destroy
      if params[:id] == "all"
        product.replacements.destroy_all
        flash[:notice] = "Náhrady byly odstraněny"
      else
        begin
          product.replacements.destroy(Product.unscoped.find(params[:id]))
          flash[:notice] = "Náhrada produktu byla odstraněna"
        rescue ActiveRecord::RecordNotFound
          flash[:error] = "Nelze najít danou náhradu"
        end
      end
      redirect_to admin_product_replacements_url(product)
    end

    private

    def allow_only_visible_and_replaced
      allowed_states = %(visible replaced)
      unless allowed_states.include?(product.state)
        flash[:error] = if product.state == "new"
                          "Nelze nahradit nový (neodsouhlasený) produkt"
                        else
                          "Lze nahradit pouze normální nebo nahrazený produkt"
                        end
        redirect_to edit_admin_product_url(product)
      end
    end

    def replacements
      @replacements ||= product.replacements
    end

    helper_method :replacements

    def product
      @product ||= ProductDecorator.decorate Product.find(params[:product_id])
    end

    helper_method :product
  end
end