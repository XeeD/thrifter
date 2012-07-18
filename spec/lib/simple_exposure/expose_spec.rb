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
        Exposure.should_receive(:new).with(:brands)
        controller.class.expose(:brands)
      end

      it "creates new Exposure with given name and block" do
        block = Proc.new {}
        Exposure.should_receive(:new).once.with(:cats, block)
        controller.class.expose(:cats) { eee }
      end

      it "creates new instance of ActiveRecordHook"

      context "singular name" do
        context "with params[:id]" do
          let(:params) { {:id => 5} }

          before do
            controller.stub!(:params).and_return(params)
          end

          it "finds the resource by that id" do
            Brand.should_receive(:find).with(params[:id])
            controller.brand
          end
        end
      end
    end
  end
end