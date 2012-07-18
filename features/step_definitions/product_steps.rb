# encoding: UTF-8

# Given statements
Pokud /^produkt "(.*?)" existuje$/ do |name|
  #Product.create!(name: "#{name}", url: ) ...
end

# When statements

# Then statements
Pak /^produkt "(.*?)" by měl být smazán$/ do |name|
  find("#products").should_not have_content("#{name}")
end

Pak /^produkt "(.*?)" by měl být (?:vytvořen|upraven)$/ do |name|
  find("#products").should have_content("#{name}")
end