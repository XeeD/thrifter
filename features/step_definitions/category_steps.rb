# encoding: UTF-8

# Given statements
Pokud /^(.+ )?kategorie "(.*?)" existuje$/ do |written_category_type, plural_name|
  category = Category.find_by_plural_name(plural_name)
  raise "category #{plural_name} doesn't exists" if category.nil?

  unless written_category_type.blank?
    written_category_type.strip!

    category_type = case written_category_type
                      when "navigační" then
                        "navigational"
                      when "produktová" then
                        "product_list"
                      when "dodatečná" then
                        "additional"
                      else
                        raise "undefined category_type #{written_category_type}"
                    end

    raise "category #{plural_name} is #{category.category_type} but expecting #{category_type}" unless category.category_type == category_type
  end
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