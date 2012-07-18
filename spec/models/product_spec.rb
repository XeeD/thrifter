require 'spec_helper'

describe Product do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:model_name) }
  it { should validate_presence_of(:short_description) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:default_price) }
  it { should validate_presence_of(:recomended_price) }
  it { should validate_presence_of(:purchase_price) }
  it { should validate_presence_of(:recycling_fee) }
  it { should validate_presence_of(:vat_rate) }
  it { should validate_presence_of(:external_id) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:is_gray_import) }
  it { should validate_presence_of(:warranty) }
  it { should validate_presence_of(:in_top_product) }

  context "with valid attributes" do
    it "should be valid" do
      Brand.new(
          name: "",
          model_name: "",
          short_description: "",
          description: "",
          default_price: "",
          recomended_price: "",
          purchase_price: "",
          recycling_fee: "",
          vat_rate: "",
          external_id: "",
          state: "",
          url: "",
          is_gray_import: "",
          warranty: "",
          in_top_producxt: ""
      ).should be_valid
    end
  end
end