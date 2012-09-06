class ProductsController < ApplicationController
  def show

  end

  private

  def product
    Category.joins(:product).where("categories.url" => params[:category_url], "products.url" => params[:product_url])
  end
end