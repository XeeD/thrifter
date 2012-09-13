# encoding: UTF-8

# Given statements
Pokud /^způsob dopravy "(.*?)" existuje$/ do |shipping_method_name|
  @shipping_method = ShippingMethod.find_by_name(shipping_method_name)
  fail "shipping method #{shipping_method_name} doesn't exists" if @shipping_method.nil?
end

Pokud /^jsem v editaci způsobu dopravy "(.*?)"$/ do |shipping_method_name|
  step "způsob dopravy \"#{shipping_method_name}\" existuje"
  step 'jsem v sekci "administrace typů dopravy"'
  step "kliknu na řádku u typu dopravy \"#{shipping_method_name}\" na odkaz \"Upravit\""
end

# When statements

# Then statements
Pak /^typ dopravy "(.*?)" by měl být smazán$/ do |shipping_method_name|
  begin
    find("#shipping_methods").should_not have_content("#{shipping_method_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^typ dopravy "(.*?)" by měl být (?:vytvořen|upraven)$/ do |shipping_method_name|
  find("#shipping_methods").should have_content("#{shipping_method_name}")
end