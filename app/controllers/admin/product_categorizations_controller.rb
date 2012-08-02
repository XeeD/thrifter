module Admin
  class ProductCategorizationsController < AdminController
    def index
    end

    def create
      categorization
      redirect_to admin_product_categorizations_url(product)
    end

    def destroy
    end


    private

    def product
      @product ||= Product.find(params[:product_id])
    end

    helper_method :product

    def categorizations
      product.categorizations
    end

    helper_method :categorizations

    def categorization
      @categorization ||= categorizations.new(params[:categorization])
    end

    helper_method :categorization
  end
end