class Admin::BrandsController < Admin::AdminController
  def index

  end

  def new

  end

  def create
    @brand = Brand.new(params[:brand])

    if @brand.save

    else

    end
    redirect_to admin_brand_path(@brand.id)
  end

  def show

  end

  def edit

  end

  def update

  end
end