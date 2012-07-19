# encoding: UTF-8

module Helpers

  def valid_product_attributes
    {
        name: "LG GB3133TIJW",
        model_name: "GB3133TIJW",
        short_description: "Chladnička",
        description: "No-Frost chladnička...",
        default_price: "12990",
        recommended_price: "15990",
        purchase_price: "9000",
        recycling_fee: "217",
        vat_rate: "20",
        external_id: "2123456",
        url: "lg-gb3133tijw",
        grey_import: "",
        warranty: "24"
    }.stringify_keys
  end

  def valid_brand_attributes
    {
        short_name: "LG",
        url: "lg",
        category_type: "LG Electronics"
    }.stringify_keys
  end

  def valid_category_attributes
    {
        short_name: "Pračky",
        url: "pracky",
        plural_name: "Pračky",
        singulare_name: "Pračka",
        category_type: "navigational"
    }.stringify_keys
  end

  RSpec.configure {|c| c.include self}
end