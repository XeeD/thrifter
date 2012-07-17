require 'spec_helper'

describe Admin::BrandsController do
  let(:brand) {
    mock_model(Brand).as_null_object
  }

  describe "GET index" do
    it "renders index of all brands" do
      get :index
      response.should be_success
    end
  end

  describe "GET new" do
    it "renders new form" do
      get :new
      response.should be_success
    end
  end

  # CREATE
  describe "POST create" do
    before do
      Brand.stub(:new).and_return(brand)
    end

    # VALID
    describe "with valid parameters" do
      it "should create a new brand" do
        Brand.should_receive(:new).and_return(brand)

        post :create, :brand => {
            "name" => "LG",
            "url"  => "lg",
            "description" => "LG Electronics"
        }
      end

      it "creates brand with exactly the given parameters"

      it "should save brand" do
        brand.should_receive(:save)
        post :create
      end

      it "should redirect to detail" do
        post :create
        response.should redirect_to(:action => "index")
      end

      it "should have a flash notice" do
        post :create
        flash[:notice].should_not be_blank
      end
    end

    # INVALID
    describe "with invalid parameters" do
      it "should render new template" do
        brand.stub(:save).and_return(false)
        post :create
        response.should render_template("new")
      end

      it "should have an error notice" do
        flash[:error].should_not be_blank
      end
    end
  end
end

#let(:brand) do
#  @brand = mock_model(Brand, :update_attributes => true)
#  Brand.stub!(:find).with("1").and_return(@brand)
#end

#it "should find brand and return object" do
#  Brand.should_receive(:find).with("1").and_return(@brand)
#end

#it "should update brand attributes" do
#  @brand.should_receive(:update_attributes).and_return(true)
#  put :update, :id => "1", :brand => {}
#end

#it "should redirect to the brand's show page" do
#  response.should redirect_to(admin_brand_url(@brand))
#end

#it "should have a flash notice" do
#  put :update, :id => "1", :bird => {}
#  flash[:notice].should_not be_blank
#end