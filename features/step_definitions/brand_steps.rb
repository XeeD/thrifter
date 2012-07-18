# encoding: UTF-8

# Given statements
Pokud /^značka "(.*?)" existuje$/ do |name|
  Brand.create!(name: "#{name}", url: "lg", description: "LG Electronics")
end

# When statements

# Then statements

Pak /^značka "(.*?)" by měla být smazána$/ do |name|
  find("#brands").should_not have_content("#{name}")
end

Pak /^značka "(.*?)" by měla být vytvořena$/ do |name|
  find("#brands").should have_content("#{name}")
end