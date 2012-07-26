# encoding: UTF-8

# Given statements
Pokud /^skupina parametrů "(.*?)" existuje$/ do |name|
  fail "param group #{name} doesn't exists" if ParamGroup.find_by_name(name).nil?
end

# When statements

# Then statements
Pak /^skupina parametrů "(.*?)" by měla být (?:vytvořena|upravena)$/ do |param_group_name|
  find("#param_groups").should have_content("#{param_group_name}")
end

Pak /^skupina parametrů "(.*?)" by měla být smazána$/ do |param_group_name|
  begin
    find("#param_groups").should_not have_content("#{param_group_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^bych měl vidět v tabulce Skupiny parametrů řádek "(.*?)"$/ do |text|
  page.should have_css("#param_groups", text: text)
end