# encoding: UTF-8

# Given statements
Pokud /^existuje šablona parametrů "(.*?)"$/ do |param_template_name|
  @param_template = ParamTemplate.find_by_name(param_template_name)
  fail "param template #{param_template_name} doesn't exists" if @param_template.nil?
end

Pokud /^šablona parametrů "(.*?)" existuje a je přiřazena kategorii "(.*?)"$/ do |param_template_name, category_name|
  step "existuje šablona parametrů \"#{param_template_name}\""
  category = Category.find_by_plural_name(category_name.to_s)

  if category.present?
    unless category.param_template === @param_template
      fail "category #{category_name} has not assigned param template '#{param_template_name}"
    end
  else
    fail "category #{category_name} doesn't exist"
  end
end

# When statements

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