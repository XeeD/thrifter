# encoding: UTF-8

module Admin
  class ProductReplacementsController < AdminController
    def index
    end

    def create
      product.replacement_ids += params[:product][:replacement_ids]

      if product.replace! & product.save!
        redirect_to admin_product_replacements_url(product), notice: "VVV"
      else
        flash.now[:error] = "Chyba při nahrazování výrobku #{product.name}"
        render :action => :index
      end
    end

    def destroy
      product.replacement_ids -= [params[:id].to_i]
      product.save!
      redirect_to :back
    end

    private

    def product
      @product ||= ProductDecorator.find(params[:product_id])
    end

    helper_method :product
  end
end