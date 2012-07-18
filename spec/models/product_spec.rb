require 'spec_helper'

describe Product do

  # Validations
  # name
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(301) }

  # model_name
  it { should validate_presence_of(:model_name) }
  it { should ensure_length_of(:name).is_at_most(150) }

  # url
  it { should validate_presence_of(:url) }
  it { should ensure_length_of(:url).is_at_most(300) }
  it { should validate_uniqueness_of(:url) }

  # short_description
  it { should validate_presence_of(:short_description) }

  # description
  it { should validate_presence_of(:description) }

  # default_price
  it { should validate_presence_of(:default_price) }
  it { should validate_numericality_of(:default_price) }

  # recommended_price
  it { should validate_presence_of(:recomended_price) }
  it { should validate_numericality_of(:recommended_price) }

  # purchase_price
  it { should validate_presence_of(:purchase_price) }
  it { should validate_numericality_of(:purchase_price) }

  # warranty
  it { should validate_presence_of(:warranty) }
  it { should validate_numericality_of(:warranty) }

  # recycling_fee
  it { should validate_presence_of(:recycling_fee) }
  it { should validate_numericality_of(:recycling_fee) }

  # vat_rate
  it { should validate_presence_of(:vat_rate) }
  it { should validate_numericality_of(:vat_rate) }

  # external_id
  it { should validate_presence_of(:external_id) }
  it { should validate_numericality_of(:external_id) }

  # state
  it { should ensure_inclusion_of(:state, in: [:new]) }

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