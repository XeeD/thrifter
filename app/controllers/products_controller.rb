class ProductsController < ApplicationController
  def show
    if params[:section] && pjax_request?
      render "section"
    end
  end

  private

  def product
    @product ||= ProductDecorator.find_by_url(params[:product_url])
  end

  helper_method :product
end