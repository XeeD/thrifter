# encoding: UTF-8

# Given statements
Pokud /^existuje produkt "(.*?)"$/ do |product_name|
  @product = Product.find_by_name(product_name)
  fail "product #{product_name} doesn't exists" if @product.nil?
end

Pokud /^existují produkty "(.*?)"$/ do |product_names|
  product_names.split(',').each do |product_name|
    fail "product #{product_name} doesn't exists" if Product.find_by_name(product_name.to_s.strip).nil?
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

Pak /^stav produktu by měl být "(.*?)"$/ do |state|
  @product.reload.state.should eq(dehumanize_state("product", state))
end

#Pak /^atribut "(.*?)" produktu by měl mít hodnotu "(.*?)"$/ do |attr, value|
#  @product.send(attr.to_s).should be value.to_s
#end