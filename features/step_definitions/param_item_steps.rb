# encoding: UTF-8

# Given statements
Pokud /^parametr "(.*?)" existuje$/ do |name|
  @param_item = ParamItem.find_by_name(name)
  fail "param #{name} doesn't exists" if @param_item.nil?
end

Pokud /^parametr "(.*?)" existuje a je přiřazen šabloně parametrů "(.*?)"$/ do |param_item_name, param_template_name|
  step "parametr \"#{param_item_name}\" existuje"
  param_template = ParamTemplate.find_by_name(param_template_name.to_s)

  if param_template.present?
    unless param_template.param_items.include?(@param_item)
      fail "param template #{param_template_name} has not assigned param item '#{param_item_name}"
    end
  else
    fail "param template #{param_template_name} doesn't exist"
  end
end
# When statements

# Then statements
Pak /^parametr "(.*?)" by měl být (?:vytvořen|upraven)$/ do |param_name|
  find("#param_items").should have_content("#{param_name}")
end

Pak /^parametr "(.*?)" by měl být smazán$/ do |param_name|
  begin
    find("#param_items").should_not have_content("#{param_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^bych měl vidět v tabulce Parametrů řádek "(.*?)"$/ do |text|
  page.should have_css("#param_items", text: text)
end