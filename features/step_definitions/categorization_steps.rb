# encoding: UTF-8

def find_shop_by_name(name)
  shop = Shop.find_by_name(name)
  raise "shop '#{name}' not found" if shop.nil?
  shop
end

def find_product_categorization(product, category)
  Categorization.where(product_id: product.id, category_id: category.id).first
end

def assert_product_in_category(product, category_path, shop_name, preferred)
  shop = find_shop_by_name(shop_name)
  category = category_from_path_in_shop(category_path, shop)
  categorization = find_product_categorization(product, category)

  raise "product #{product.name} is not in category '#{category_path}'" if categorization.nil?

  if preferred
    categorization.should be_preferred
  else
    categorization.should_not be_preferred
  end
end

Pokud /^(?:je produkt zařazen|je zařazen) v (hlavní|alternativní) kategorii "(.*?)" v obchodu "(.*?)"$/ do |preferrence, category_path, shop_name|
  assert_product_in_category(@product, category_path, shop_name, preferrence == "hlavní")
end

Pokud /^není produkt zařazen v kategorii "(.*?)" v obchodu "(.*?)"$/ do |category_path, shop_name|
  shop = find_shop_by_name(shop_name)
  category = category_from_path_in_shop(category_path, shop)
  find_product_categorization(@product, category).should be_nil
end

Když /^u obchodu "(.*?)" kliknu na odkaz "(.*?)"$/ do |shop_name, link_text|
  @shop = Shop.find_by_name(shop_name)
  dom_id = ActionController::RecordIdentifier.dom_id(@shop)
  within("##{dom_id}") do
    click_link link_text
    save_page
  end
end

def category_check_box(category_path)
  category = category_from_path_in_shop(category_path, @shop)
  find_field("product_category_ids_#{category.id}")
end

Když /^zaškrtnu pole u kategorie "(.*?)"$/ do |category_path|
  category = category_from_path_in_shop(category_path, @shop)
  check "product_category_ids_#{category.id}"
end

Když /^zruším zaškrtnutí pole u kategorie "(.*?)"$/ do |category_path|
  category = category_from_path_in_shop(category_path, @shop)
  uncheck "product_category_ids_#{category.id}"
end

Pak /^by mělo být zatržené pole u kategorie "(.*?)"(, ale nemělo by jít změnit)?$/ do |category_path, disable|
  category_check_box(category_path).should be_checked
  if disable.present?
    category_check_box(category_path)["disabled"].should be_true
  end
end

Pak /^nemělo by ani jít zaškrtnout pole "(.*?)" \(mimo jiné\)$/ do |category_path|
  category_check_box(category_path)["disabled"].should be_true
end

Pak /^by měl produkt být zařazen v alternativní kategorii "(.*?)" v obchodu "(.*?)"$/ do |category_path, shop_name|
  assert_product_in_category(@product, category_path, shop_name, false)
end

Pak /^by neměl produkt být zařazen v kategorii "(.*?)"$/ do |category_path|
  expect {
    assert_product_in_category(@product, category_path, @shop.name, false)
  }.to raise_error(RuntimeError)
end