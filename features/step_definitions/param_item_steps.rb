# encoding: UTF-8

# Given statements
Pokud /^parametr "(.*?)" existuje$/ do |name|
  fail "param #{name} doesn't exists" if Param.find_by_name(name).nil?
end

# When statements

# Then statements
Pak /^parametr "(.*?)" by měl být (?:vytvořen|upraven)$/ do |param_name|
  find("#params").should have_content("#{param_name}")
end

Pak /^parametr "(.*?)" by měl být smazán$/ do |param_name|
  begin
    find("#params").should_not have_content("#{param_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^bych měl vidět v tabulce Parametrů řádek "(.*?)"$/ do |text|
  page.should have_css("#params", text: text)
end