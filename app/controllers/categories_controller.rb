class CategoriesController < ApplicationController
  def index
    @title = params[:category_url]
    @category_name = params[:category_url]
    set_pjax_data(:active_menu, params[:category_url])
    set_pjax_data(:eval, "")
  end
end