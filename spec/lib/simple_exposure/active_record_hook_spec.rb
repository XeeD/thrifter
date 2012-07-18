require "simple_exposure/active_record_hook"
require "simple_exposure/exposure"

class Brand
end

module SimpleExposure
  describe ActiveRecordHook do
    let(:params) { Hash.new }
    let(:exposure) { Exposure.new(:brand) }
    let(:collection_exposure) { Exposure.new(:brands) }
    let(:hook) { ActiveRecordHook.new(exposure) }
    let(:collection_hook) { ActiveRecordHook.new(collection_exposure) }

    before do
      hook.stub(:pluralize) do |name|
        case name.to_s
          when "brand"
            "brands"
          when "brands"
            "brands"
        end
      end
    end

    context "#exposed_collection?" do
      it "returns true if exposed name is pluralized" do
        collection_hook.should be_exposed_collection
      end

      it "returns false if exposed name is not pluralized" do
        hook.should_not be_exposed_collection
      end
    end

    context "#model" do
      it "return model class for given singular name" do
        hook.model.should == Brand
      end

      it "returns model class for given pluralized name" do
        collection_hook.model.should == Brand
      end
    end

    context "#find" do
      context "with singular exposure name" do
        context "with :id defined in params" do
          let(:params) { {:id => "4"} }
          let(:brand_mock) { mock("Brand").as_null_object }

          it "finds the resource by id" do
            Brand.should_receive(:find).with(params[:id])
            hook.find(params)
          end

          it "uses id from params" do
            hook.stub(:model).and_return(brand_mock)
            params.should_receive(:[]).with(:brand_id).and_return(nil)
            params.should_receive(:[]).with(:id)
            hook.find(params)
          end
        end

        context "with 'exposure_name'_id defined in params" do
          let(:params) { {:brand_id => "5", :id => "4"} }
          it "finds the resource by the id" do
            Brand.should_receive(:find).with(params[:brand_id])
            hook.find(params)
          end
        end

        context "with no id defined in params" do
          it "returns new instance" do
            Brand.should_receive(:new).once
            hook.find(params)
          end
        end
      end

      context "with plural exposure name" do
        it "finds the resources using default scope" do
          Brand.should_receive(:all).once
          collection_hook.find(params)
        end
      end

      context "using exposure with block" do
        let(:block) { Proc.new {} }
        let(:exposure) { Exposure.new(:brand, block) }

        it "should use the block to retrieve the resource" do
          block.should_receive(:call).once
          hook.find(params)
        end
      end
    end
  end
end