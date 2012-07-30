# encoding: UTF-8
require 'spec_helper'

module Admin
  describe ProductPhotosController do
    let(:product_photo) { mock_model(Product::Photo).as_null_object }
    let(:product) { Product.find_by_name("Samsung UE55ES8000") }
    let(:new_product_photo) { mock_model(Product::Photo).as_new_record }

    before do
      Product.stub(find: product)
      product.stub_chain(:photos, :new).with(nil).and_return(new_product_photo)
    end

    describe "GET index" do
      def get_index
        get :index, product_id: product.id
      end

      it "renders 'index' template" do
        get_index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        before do
          product.stub_chain(:photos, :empty?).and_return(true)
          product.photos.stub(reject: [])
        end

        it "calls new through Product.photos" do
          product.photos.should_receive(:new).with(nil).once
          get_index
        end

        it "shows form" do
          get_index
          response.body.should have_selector("form")
        end

        it "contains the name of product that the photos belong to" do
          get_index
          response.body.should have_selector("h2", content: product.name)
        end
      end
    end

    describe "POST create" do
      def post_create(product_photo_attributes=nil)
        post :create, product_id: product.id, product_photo: product_photo_attributes
      end

      before do
        new_product_photo.stub(save: true)
      end

      # Valid attributes
      context "with valid attributes" do

        def post_valid_attributes
          post_create(valid_product_photo_attributes)
        end

        it "creates new instance of ProductPhoto with those attributes" do
          product.photos.should_receive(:new).with(valid_product_photo_attributes).once
          post_valid_attributes
        end

        it "redirects to index" do
          post_create
          response.should redirect_to(admin_product_photos_url(product))
        end

        it "saves the record" do
          new_product_photo.should_receive(:save).and_return(true)
          post_create
        end

        it "sets notice message" do
          post_create
          flash[:notice].should_not be_blank
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          new_product_photo.stub(:save).and_return(false)
        end

        it "sets error message for current request" do
          post_create
          flash.now[:error].should_not be_blank
        end

        it "renders 'index' template again (it contains the form)" do
          post_create
          response.should render_template("index")
        end
      end
    end

    describe "GET edit" do
      def get_edit
        get :edit, product_id: product.id, id: product_photo.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          product.stub_chain(:photos, :find).and_return(product_photo)
        end

        it "finds the product photo" do
          product.photos.should_receive(:find).with(product_photo.id.to_s).once
          get_edit
        end

        it "renders edit form" do
          get_edit
          response.body.should have_selector("form")
        end
      end
    end

    describe "PUT update" do
      def put_update(attributes={})
        put :update,
            product_id: product.id,
            id: product_photo.id,
            product_photo: valid_product_photo_attributes
      end

      before do
        product.stub_chain(:photos, :find).and_return(product_photo)
      end

      # Valid attributes
      context "with valid attributes" do
        def put_update_with_valid_attributes
          put_update(product_photo: valid_product_photo_attributes)
        end

        it "finds the product photo" do
          product.photos.should_receive(:find).with(product_photo.id.to_s).once.and_return(product_photo)
          put_update_with_valid_attributes
        end

        it "updates attributes" do
          product_photo.should_receive(:update_attributes).with(valid_product_photo_attributes).once
          put_update_with_valid_attributes
        end

        it "redirects to index" do
          put_update_with_valid_attributes
          response.should redirect_to(admin_product_photos_url(product))
        end

        it "sets notice message" do
          put_update_with_valid_attributes
          flash[:notice].should_not be_blank
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        before do
          product_photo.stub(:update_attributes).and_return(false)
        end

        it "renders edit action again" do
          put_update
          response.should render_template("edit")
        end

        it "sets error message for current request" do
          put_update
          flash.now[:error].should_not be_blank
        end
      end

      context "with non-existing product photo id" do
        def put_with_invalid_id
          put :update, product_id: product.id, id: product_photo.id + 1
        end

        before do
          product.stub_chain(:photos, :find).and_raise(ActiveRecord::RecordNotFound)
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_product_photos_url(product))
        end

        it "sets error message" do
          put_with_invalid_id
          flash[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      def delete_product_photo
        delete :destroy, product_id: product.id, id: product_photo.id
      end

      before do
        product.stub_chain(:photos, :find).and_return(product_photo)
      end

      it "redirects to index" do
        delete_product_photo
        response.should redirect_to(admin_product_photos_url(product))
      end

      context "with valid product photo id" do
        it "destroys the product photo" do
          product_photo.should_receive(:destroy).once
          delete_product_photo
        end

        it "sets notice message" do
          delete_product_photo
          flash[:notice].should_not be_blank
        end
      end

      context "with non-existing product photo id" do
        def delete_invalid_product_photo
          delete :destroy, product_id: product.id, id: product_photo.id + 1
        end

        it "sets error message" do
          product.stub_chain(:photos, :find).and_raise(ActiveRecord::RecordNotFound)
          delete_invalid_product_photo
          flash[:error].should_not be_blank
        end
      end
    end

    describe "POST sort" do
      it "sets position to photos according to sent params" do
        product = Product.find_by_name("Samsung UE55ES8000")
        old_order = product.photos.order(:position).pluck(:id)
        new_order_post = old_order.reverse

        post :sort, product_id: product.id, product_photo: new_order_post

        new_order = product.photos.order(:position).pluck(:id)
        new_order.should == old_order.reverse
      end
    end
  end
end