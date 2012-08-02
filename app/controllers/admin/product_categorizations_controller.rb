module Admin
  class ProductCategorizationsController < AdminController
    def index
    end

    def create
      if categorization.save
        redirect_to admin_product_categorizations_url(product)
      else
        flash.now[:error] = categorization.errors_on(:base)
        render :index
      end
    end

    def destroy
      categorization.destroy
    rescue ActiveRecord::ActiveRecordError => exception
      flash[:error] = exception.message
    ensure
      redirect_to admin_product_categorizations_url
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
      @categorization ||= params[:id] ?
          categorizations.find(params[:id]) :
          categorizations.new(params[:categorization])
    end

    helper_method :categorization
  end
end