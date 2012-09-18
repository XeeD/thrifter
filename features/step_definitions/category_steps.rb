# encoding: UTF-8

# Given statements
Pokud /^(.+ )?kategorie "(.+)" v obchodu "(.+)" existuje$/ do |written_category_type, plural_name, shop_name|
  shop = Shop.find_by_name(shop_name)
  raise "shop '#{shop_name}' doesn't exist" if shop.nil?

  category = Category.find_by_plural_name(plural_name)
  raise "category #{plural_name} doesn't exists" if category.nil?

  unless written_category_type.blank?
    written_category_type.strip!

    category_type = case written_category_type
                      when "navigační" then
                        :navigational
                      when "produktová" then
                        :product_list
                      when "dodatečná" then
                        :additional
                      else
                        raise "undefined category_type #{written_category_type}"
                    end

    category.category_type.should == category_type
  end
end

Pokud /^přidávám novou kategorii pro obchod "(.*?)"$/ do |shop_name|
  step "mám otevřenou administraci kategorií pro obchod \"#{shop_name}\""
  step 'kliknu na odkaz "Přidat novou kategorii"'
end

Pokud /^mám otevřenou administraci kategorií pro obchod "(.+)"$/ do |shop_name|
  shop = Shop.find_by_name(shop_name)
  raise "shop '#{shop_name}' doesn't exist" if shop.nil?

  visit admin_shop_categories_path(shop)
end

Pak /^kategorie "(.*?)" by měla být smazána$/ do |category_name|
  begin
    find("#categories").should_not have_content("#{category_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^kategorie "(.*?)" by měla být (?:vytvořena|upravena)$/ do |category_name|
  find("#categories").should have_content("#{category_name}")
end

Pak /^kategorie "(.*?)" by neměla mít šablonu parametrů "(.*?)$/ do |category_name, param_template_name|
  lambda {
    step "kategorie \"#{category_name}\" by měla mít šablonu parametrů \"#{param_template_name}\""
  }.should raise_error(RuntimeError)
end

Pak /^kategorie "(.*?)" by měla mít šablonu parametrů "(.*?)"$/ do |category_name, param_template_name|
  category = Category.find_by_plural_name(category_name)

  if category.present?
    if category.param_template.present?
      unless category.param_template.name == param_template_name
        raise "category #{category_name} has not assigned param template #{param_template_name}"
      end
    else
      raise "category #{category_name} has no param template assigned"
    end
  else
    raise ActiveRecord::RecordNotFound
  end
end