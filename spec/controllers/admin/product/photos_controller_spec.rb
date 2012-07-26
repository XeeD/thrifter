require "spec_helper"

module Admin
  describe Product::PhotosController do
    fixtures :products

    let(:product) { fail products.inspect;products[:lg_fridge] }

    describe "GET new" do
      it "renders 'new' template" do
        get :new, product_id: product.id
      end
    end
  end
end