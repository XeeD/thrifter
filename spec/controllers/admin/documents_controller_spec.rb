# encoding: UTF-8
require 'spec_helper'

module Admin
  describe DocumentsController do
    let(:document) { mock_model(Document).as_null_object }

    describe "GET index" do
      def get_index
        get :index
      end

      it "renders index action" do
        get_index
        response.should render_template("index")
      end

      context "when rendering views" do
        render_views

        it "calls Document#page" do
          Document.should_receive(:page).with(nil).and_return(document)
          get_index
        end
      end
    end

    describe "GET new" do
      def get_new
        get :new
      end

      it "renders new action" do
        get_new
        response.should render_template("new")
      end

      context "when rendering views" do
        render_views

        it "calls Document#new" do
          Document.should_receive(:new).with(nil).and_return(document)
          get_new
        end

        it "shows form" do
          get_new
          response.body.should have_selector("form")
        end
      end
    end

    describe "POST create" do
      before do
        Document.stub(:new).and_return(document)
      end

      def post_valid_attributes
        post :create, document: valid_document_attributes
        document.stub(:save).and_return(true)
      end

      # Valid attributes
      context "with valid attributes" do
        it "creates new instance of document with those attributes" do
          Document.should_receive(:new).with(valid_document_attributes).once
          post_valid_attributes
        end

        it "saves the record" do
          document.should_receive(:save).once.and_return(true)
          post_valid_attributes
        end

        it "redirects to index" do
          post_valid_attributes
          response.should redirect_to(admin_documents_url)
        end

        it "sets the notice message with document's name" do
          document.stub(name: valid_document_attributes["name"])
          post_valid_attributes
          flash[:notice].should include(document.name)
        end
      end

      context "with invalid attributes" do
        before do
          document.stub(:save).and_return(false)
        end

        it "renders the template 'new' again" do
          post_valid_attributes
          response.should render_template("new")
        end

        it "sets error message for current request" do
          post_valid_attributes
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "GET edit" do
      def get_edit
        get :edit, id: document.id
      end

      it "renders template 'edit'" do
        get_edit
        response.should render_template("edit")
      end

      context "when rendering views" do
        render_views

        before do
          Document.stub(:find).with(document.id.to_s).and_return(document)
        end

        it "finds the document" do
          Document.should_receive(:find).with(document.id.to_s).once.and_return(document)
          get_edit
        end

        it "shows form" do
          get_edit
          response.body.should have_selector("form")
        end
      end
    end

    describe "POST update" do
      # Valid attributes
      context "with valid attribtues" do
        def put_with_valid_attributes
          post :update, id: document.id, document: valid_document_attributes
        end

        before do
          Document.stub(:find).and_return(document)
        end

        it "receives find with document's id" do
          Document.should_receive(:find).with(document.id.to_s).and_return(document)
          put_with_valid_attributes
        end

        it "updates document's attributes" do
          document.should_receive(:update_attributes).with(valid_document_attributes).once.and_return(true)
          put_with_valid_attributes
        end

        it "redirects to documents" do
          put_with_valid_attributes
          response.should redirect_to(admin_documents_url)
        end

        it "sets notice message containing document's name" do
          document.stub(name: valid_document_attributes["name"])
          put_with_valid_attributes
          flash[:notice].should include(document.name)
        end
      end

      # Invalid attributes
      context "with invalid attributes" do
        def put_with_invalid_attributes
          put :update, id: document.id, document: {}
        end

        before do
          document.stub(:update_attributes).and_return(false)
          Document.stub(:find).and_return(document)
        end

        it "renders form for editing again" do
          put_with_invalid_attributes
          response.should render_template("edit")
        end

        it "sets error message for current request" do
          put_with_invalid_attributes
          flash.now[:error].should_not be_blank
        end
      end

      context "with non-existing document id" do
        def put_with_invalid_id
          put :update, id: document.id + 1
        end

        it "redirects to index" do
          put_with_invalid_id
          response.should redirect_to(admin_documents_url)
        end

        it "sets error message" do
          put_with_invalid_id
          flash.now[:error].should_not be_blank
        end
      end
    end

    describe "DELETE destroy" do
      def delete_document
        delete :destroy, id: document.id
      end

      context "with valid document id" do
        before do
          Document.stub(:find).and_return(document)
        end

        it "finds the document" do
          Document.should_receive(:find).with(document.id.to_s).once
          delete_document
        end

        it "redirects to index" do
          delete_document
          response.should redirect_to(admin_documents_url)
        end

        it "destroys the document" do
          document.should_receive(:destroy).once.and_return(true)
          delete_document
        end

        it "displays message with deleted document's name" do
          document.stub(name: valid_document_attributes["name"])
          delete_document
          flash[:notice].should include(document.name)
        end
      end

      context "with invalid document id" do
        def delete_with_invalid_id
          delete :destroy, id: document.id + 1
        end

        it "redirects back to index" do
          delete_with_invalid_id
          response.should redirect_to(admin_documents_url)
        end

        it "sets error message" do
          delete_with_invalid_id
          flash[:error].should_not be_blank
        end
      end
    end
  end
end