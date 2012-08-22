# encoding: UTF-8

module Admin
  class ProductReplacementsController < AdminController
    def index
    end

    def create
      product.replacement_ids += params[:product][:replacement_ids]

      if product.replace! & product.save!
        redirect_to admin_product_replacements_url(product), notice: ""
      else
        flash.now[:error] = "Chyba při nahrazování výrobku #{product.name}"
        render :action => :index
      end
    end

    def destroy
      if params[:id] == "all"
        product.replacement_ids = []
      else
        product.replacement_ids -= [params[:id].to_i]
      end

      if product.replacement_ids.empty?
        product.revert_replace!
      end

      product.save!

      redirect_to :back
    end

    private

    def replacements
      @replacements ||= product.replacements
    end

    helper_method :replacements

    def product
      @product ||= ProductDecorator.decorate Product.with_states(:visible, :replaced).find(params[:product_id])
    end

    helper_method :product
  end
end