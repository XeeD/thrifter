# encoding: UTF-8

# Given statements


# When statements
Když /^u produktu "(.*?)" kliknu na "(.*?)"$/ do |name, link|
  pending
end

Když /^produkt "(.*?)" existuje$/ do |name|
  Product.exists?(:name => name)
end

Když /^jsem v editaci produktu "(.*?)"$/ do |name|
  pending
  #visit edit_admin_product_path(Product.find_by_name(name))
end

# Then statements
Pak /^produkt "(.*?)" by měl být vytvořen$/ do |name|
  pending
end

Pak /^měl bych vidět produkt se jménem "(.*?)"$/ do |name|
  pending
end

Pak /^název produktu by měl být "(.*?)"$/ do |name|
  pending
end
