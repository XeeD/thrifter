# encoding: UTF-8

# Given statements
Pokud /^kategorie "(.*?)" existuje$/ do |name|
  Category.create!(short_name: "#{name}", url: "pracky", plural_name: "Pračky", singular_name: "Pračka", category_type: "navigational")
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