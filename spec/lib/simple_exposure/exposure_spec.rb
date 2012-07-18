require "simple_exposure/exposure"

module SimpleExposure
  describe Exposure do
    subject(:exposure) { Exposure.new(:brand) }
    let(:block) { Proc.new {} }

    describe "#name" do
      it("returns exposure'name") { exposure.name.should == :brand }
    end

    describe "#block" do

    end

    describe "#exposure_with_block?" do

      it "returns true if block was given to constructor" do
        exposure = Exposure.new(:brand, block)
        exposure.should be_exposure_with_block
      end

      it "return false if no block was given to constructor" do
        exposure.should_not be_exposure_with_block
      end
    end

    describe "block" do
      it "returns the block given to constructor" do
        exposure = Exposure.new(:brand, block)
        exposure.block.should == block
      end
    end
  end
end