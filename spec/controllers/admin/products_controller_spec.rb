require 'spec_helper'

module Admin
  describe ProductsController do
    it "should render index" do
      get :index
      response.should be_success
    end
  end
end