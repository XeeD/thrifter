# encoding: UTF-8

module Admin
  class ProductParamItemsController < AdminController
    def index
    end

    private

    def product
      @product ||= Product.find(params[:product_id])
    end

    helper_method :product
  end
end