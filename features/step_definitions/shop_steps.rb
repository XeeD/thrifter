# encoding: UTF-8

Pokud /^obchod "(.*?)" existuje$/ do |name|
  raise "shop #{name} doesn't exist" if Shop.find_by_name(name).nil?
end

Pak /^obchod "(.*?)" by měl být smazán$/ do |name|
  begin
    find("#shops").should_not have_content("#{name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^obchod "(.*?)" by měl být (?:vytvořen|upraven)$/ do |name|
  find("#shops").should have_content("#{name}")
end