# encoding: UTF-8

# Given statements
Pokud /^existuje šablona parametrů "(.*?)"$/ do |param_template_name|
  fail "param template #{param_template_name} doesn't exists" if ParamTemplate.find_by_name(param_template_name).nil?
end


# Then statements
Pak /^šablona parametrů "(.*?)" by měla být smazána$/ do |param_template_name|
  begin
    find("#param_templates").should_not have_content("#{param_template_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^šablona parametrů "(.*?)" by měla být (?:vytvořena|upravena)$/ do |param_template_name|
  find("#param_templates").should have_content("#{param_template_name}")
end