# encoding: UTF-8

# Given statement
Pokud /^článek "(.+)" v obchodu "(.+)" existuje$/ do |article_name, shop_name|
  shop = Shop.find_by_name(shop_name)
  raise "shop '#{shop_name}' doesn't exist" if shop.nil?

  @article = Article.find_by_name(article_name)
  shop.articles.should include(@article)
end

Pokud /^mám otevřenou administraci článků pro obchod "(.+)"$/ do |shop_name|
  shop = Shop.find_by_name(shop_name)
  raise "shop '#{shop_name}' doesn't exist" if shop.nil?

  visit admin_shop_articles_path(shop)
end

Pokud /^přidávám nový článek pro obchod "(.*?)"$/ do |shop_name|
  step "mám otevřenou administraci článků pro obchod \"#{shop_name}\""
  step 'kliknu na odkaz "Přidat nový článek"'
end
# When statements

# Then statements
Pak /^článek "(.*?)" by měl být smazán$/ do |article_name|
  begin
    find("#articles").should_not have_content("#{article_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^článek "(.*?)" by měl být (?:vytvořen|upraven)$/ do |article_name|
  find("#articles").should have_content("#{article_name}")
end