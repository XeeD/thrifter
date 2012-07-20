# encoding: UTF-8

# Given statements
Pokud /^kategorie "(.*?)" existuje$/ do |short_name|
  fail "category #{short_name} doesn't exists" if Category.find_by_short_name(short_name).nil?
end

Pokud /^jsem v editaci kategorie "(.*?)"$/ do |name|
  step "kategorie \"#{name}\" existuje"
  step 'jsem v sekci "administrace kategorií"'
  step 'kliknu na odkaz "Upravit"'
end

# When statements

# Then statements
Pak /^kategorie "(.*?)" by měla být smazána$/ do |name|
  begin
    find("#categories").should_not have_content("#{name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^kategorie "(.*?)" by měla být (?:vytvořena|upravena)$/ do |name|
  find("#categories").should have_content("#{name}")
end