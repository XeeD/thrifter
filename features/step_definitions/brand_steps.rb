# encoding: UTF-8

# Given statements
Pokud /^značka "(.*?)" existuje$/ do |brand_name|
  fail "brand #{brand_name} doesn't exists" if Brand.find_by_name(brand_name).nil?
end

Pokud /^jsem v editaci značky "(.*?)"$/ do |name|
  step "značka \"#{name}\" existuje"
  step 'jsem v sekci "administrace značek"'
  step 'kliknu na odkaz "Upravit"'
end

# When statements

# Then statements

Pak /^značka "(.*?)" by měla být smazána$/ do |name|
  begin
    find("#brands").should_not have_content("#{name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^značka "(.*?)" by měla být (?:vytvořena|upravena)$/ do |name|
  find("#brands").should have_content("#{name}")
end