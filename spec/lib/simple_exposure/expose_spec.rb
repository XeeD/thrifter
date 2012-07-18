require "simple_exposure/expose"
require "action_controller"

class BrandController < ActionController::Base
  extend SimpleExposure::Expose
  expose :brand
end
class Brand;
end

module SimpleExposure
  describe Expose do
    context ".expose" do
      let(:params) { {} }
      let(:controller) { controller = BrandController.new }

      before do
        controller.stub!(:params).and_return(params)
      end

      it "defines method with exposed name" do
        controller.should respond_to(:brand)
      end

      it "exposes the method to the view as helper" do
        controller._helper_methods.should include(:brand)
      end

      it "hides the method so it is not accessible from the outside" do
        controller.hidden_actions.should include("brand")
      end

      it "creates new Exposure with given name" do
        Exposure.should_receive(:new).with(:brands, nil)
        controller.class.expose(:brands)
      end

      it "creates new Exposure with given name and block" do
        block = Proc.new {}
        Exposure.should_receive(:new).once.with(:brands, block)
        controller.class.expose(:brands, &block)
      end

      context "singular name" do
        context "with params[:id]" do
          let(:params) { {id: 5} }

          it "finds the resource by that id" do
            controller.stub!(:params).and_return(params)
            Brand.should_receive(:find).with(params[:id])
            controller.brand
          end
        end

        context "with params[:'exposure_name'_id]" do
          let(:params) { {brand_id: 6, id: 4} }

          it "finds the resource by that id" do
            Brand.should_receive(:find).with(params[:brand_id])
            controller.brand
          end
        end
      end

      context "plural name" do
        context "with no block given" do
          it "uses model's default scope to find resource" do
            controller.class.expose(:brands)
            Brand.should_receive(:all).once
            controller.brands
          end
        end

        context "with block given" do
          it "uses the block to find resource" do
            block = Proc.new {}
            controller.class.expose(:brands, &block)
            block.should_receive(:call).once
            controller.brands
          end
        end
      end
    end
  end
end
