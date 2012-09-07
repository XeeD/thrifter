class ProductsController < ApplicationController
  def show
    if params[:section] && pjax_request?
      render "section"
    #else
      #set_pjax_data(:eval, "$('a[data-pjax-remote]').pjax('[data-pjax-section-container]')")
    end
  end

  private

  def product
    @product ||= Product.find_by_url(params[:product_url])
  end

  helper_method :product
end