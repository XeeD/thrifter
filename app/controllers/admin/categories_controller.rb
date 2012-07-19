module Admin
  class CategoriesController < AdminController
    def index
    end

    def new
    end

    private

    def category
      @category ||= params[:id] ? Category.find(params[:id]) : Brand.new(params[:category])
    end

    helper_method :category

    def categories
      @categories ||= Category.all
    end

    helper_method :categories
  end
end