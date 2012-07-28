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
        gray_import: "",
        warranty: "24",
        brand_id: "1"
    }.stringify_keys
  end

  def valid_brand_attributes
    {
        name: "LG",
        url: "lg",
        description: "LG Electronics"
    }.stringify_keys
  end

  def valid_category_attributes
    {
        short_name: "Pračky",
        url: "pracky",
        plural_name: "Pračky",
        singular_name: "Pračka",
        category_type: "navigational"
    }.stringify_keys
  end

  def valid_param_template_attributes
    {
        name: "Plazmové televize"
    }.stringify_keys
  end

  def valid_param_group_attributes
    {
        name: "Parametry"
    }.stringify_keys
  end

  def valid_param_item_attributes
    {
        name: "Výška",
        unit: "cm",
        value_type: "int",
        choice_type: "input",
        importance: "sortable",
        param_template_id: "1"
    }.stringify_keys
  end

  def valid_shop_attributes
    {
        short_name: "smart_beko_cz",
        name: "Smart Beko",
        host: "s-beko.cz"
    }.stringify_keys
  end

  def valid_product_photo_attributes
    {
        title: "detail ovládání",
        product_id: "1"
    }.stringify_keys
  end

  RSpec.configure {|c| c.include self}
end