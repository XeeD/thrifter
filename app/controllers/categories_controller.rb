class CategoriesController < ApplicationController
  def index
    set_pjax_data(:active_menu, params[:category_url])
  end

  private
  def category
    @category ||= Category.includes(:products).find_by_url(params[:category_url])
  end

  helper_method :category
end