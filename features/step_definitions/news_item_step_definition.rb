# encoding: UTF-8

# Given statements
Pokud /^novinka "(.+)" v obchodu "(.+)" existuje$/ do |news_title, shop_name|
  shop = Shop.find_by_name(shop_name)
  raise "shop '#{shop_name}' doesn't exist" if shop.nil?

  news_item = NewsItem.find_by_title(news_title)
  shop.news_items.should include(news_item)
end

Pokud /^mám otevřenou administraci novinek pro obchod "(.+)"$/ do |shop_name|
  shop = Shop.find_by_name(shop_name)
  raise "shop '#{shop_name}' doesn't exist" if shop.nil?

  visit admin_shop_news_items_path(shop)
end

# When statements

# Then statements
Pak /^novinka "(.*?)" by měla být smazána$/ do |news_item_name|
  begin
    find("#news_items").should_not have_content("#{news_item_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^novinka "(.*?)" by měla být (?:vytvořena|upravena)$/ do |news_item_name|
  find("#news_items").should have_content("#{news_item_name}")
end