class Admin::BrandsController < Admin::AdminController
  before_filter :load_object

  def index

  end

  def new

  end

  def create
  end

  def show

  end

  def edit

  end

  def update

  end

  private
  def load_object
    @brand = Brand.find(params[:id]) unless params[:id].blank?
    @brand ||= Brand.new(params[:brand])
  end
end