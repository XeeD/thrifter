class CategoriesController < ApplicationController
  def index
    @title = params[:category]
    @category_name = params[:category]
  end
end