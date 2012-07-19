# encoding: UTF-8

# Given statements
Pokud /^existuje produkt "(.*?)"$/ do |product_name|
  fail "product #{product_name} doesn't exists" if Product.find_by_name(product_name).nil?
end


# When statements

# Then statements
Pak /^produkt "(.*?)" by měl být smazán$/ do |name|
  find("#products").should_not have_content("#{name}")
end

Pak /^produkt "(.*?)" by měl být (?:vytvořen|upraven)$/ do |name|
  find("#products").should have_content("#{name}")
end