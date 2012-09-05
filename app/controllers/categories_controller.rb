class CategoriesController < ApplicationController
  def index
    @title = params[:category]
    @category_name = params[:category]
    @pjax_data = {active_menu: params[:category]}
  end
end