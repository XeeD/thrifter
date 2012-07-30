# encoding: UTF-8

# Given statements
Pokud /^existuje produkt "(.*?)"$/ do |product_name|
  @product = Product.find_by_name(product_name)
  fail "product #{product_name} doesn't exists" if @product.nil?
end

Pokud /^upravuji produkt "(.*?)"$/ do |product_name|
  @product = Product.find_by_name(product_name)
  raise "product #{product_name} not found" if @product.nil?
  visit edit_admin_product_path(@product)
end

Pokud /^parametr "(.*?)" je přiřazen produktu$/ do |param_item_name|
  @param_item = ParamItem.find_by_name(param_item_name)
  raise "param item #{param_item_name} not found" if @param_item.blank?
  unless @product.template_param_items.include?(@param_item)
    raise "param item \"#{param_item_name}\" is not assigned to product"
  end
end

# When statements

# Then statements
Pak /^produkt "(.*?)" by měl být smazán$/ do |name|
  begin
    find("#products").should_not have_content("#{name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^produkt "(.*?)" by měl být (?:vytvořen|upraven)$/ do |name|
  find("#products").should have_content("#{name}")
end