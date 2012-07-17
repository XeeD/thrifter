# encoding: UTF-8

class Admin::BrandsController < Admin::AdminController
  expose(:brands)
  expose(:brand)

  def index
  end

  def new
  end

  def create
    if brand.save
      redirect_to admin_brands_path, :notice => "Značka #{brand.name} byla vytvořena"
    else
      render :action => :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end
end