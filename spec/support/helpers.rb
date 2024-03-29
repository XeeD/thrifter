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
        brand_id: "1",
        weight: "20"
    }.stringify_keys
  end

  def valid_brand_attributes
    {
        name: "Sencor",
        url: "sencor",
        description: "Sencor Electronics"
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
        name: "Tloušťka",
        unit: "cm",
        value_type: "int",
        choice_type: "input",
        importance: "sortable",
        param_template_id: "1"
    }.stringify_keys
  end

  def valid_param_value_attributes
    {
        value: "100",
        param_item_id: 1
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

  def valid_news_item_attributes
    {
        title: "BestShop",
        content: "Nejlepší obchod roku",
        link: "/best-shop/"
    }.stringify_keys
  end

  def valid_article_attributes
    {
        name: "Plazma TV",
        title: "Plazma TV",
        url: "plazma-tv",
        content: "Plazmové televize jsou nyní ještě barevnější",
        summary: "Více barev od plazmových televizí",
        category_ids: ["11", "13"]
    }.stringify_keys
  end

  def valid_document_attributes
    {
        name: "Obchodní podmínky",
        url: "obchodni-podminky",
        title: "Obchodní podmínky",
        content: "Nejsou žádné",
        shop_ids: ["1"]
    }.stringify_keys
  end

  def valid_order_attributes
    {
        number: "11223344",
        token: "azkkHKjd778Dw",
        item_total: "10252",
        state: "in_progress"
    }.stringify_keys
  end

  def valid_shipping_method_attributes
    {
        name: "PPL",
        short_description: "Dopravní služba PPL",
        description: "PPL zaručuje doručení zboží do druhého dne"
    }.stringify_keys
  end

  def valid_package_size_attributes
    {
        weight_min: 0,
        weight_max: 20,
        price: 100
    }.stringify_keys
  end

  def valid_payment_method_attributes
    {
        name: "Dobírka",
        short_description: "Platba při převzetí zboží",
        description: "Nejběžnější způsob platby",
        shop_ids: ["1"]
    }.stringify_keys
  end

  RSpec.configure {|c| c.include self}
end