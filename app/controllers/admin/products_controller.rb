module Admin
  class ProductsController < AdminController


    private

    def product
      @product ||= Product.new
    end
    helper_method :product
  end
end