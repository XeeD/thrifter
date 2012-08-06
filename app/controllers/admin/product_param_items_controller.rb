# encoding: UTF-8

module Admin
  class ProductParamItemsController < AdminController
    def index
    end

    def create
      processor = ProductParamItemsProcessor.new(params[:product_id])
      if processor.save_params(params[:param_items])
        flash[:notice] = "Parametry produktu #{product.name} byly uloženy"
      end

      redirect_to :back
    end

    private

    helper_method :assigned_param_values

    def product
      @product ||= ProductDecorator.find(params[:product_id])
    end

    helper_method :product
  end
end