# encoding: UTF-8

# Given statements
Pokud /^značka "(.*?)" existuje$/ do |name|
  Brand.exists?(:name => name)
end

# When statements

# Then statements

Pak /^značka "(.*?)" by měla být smazána$/ do |name|
  Brand.exists?(:name => name)
end

Pak /^značka "(.*?)" by měla být vytvořena$/ do |name|
  find("#brands").should have_content("LG")
end