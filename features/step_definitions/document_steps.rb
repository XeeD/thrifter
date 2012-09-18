# encoding: UTF-8

# Given statements
Pokud /^dokument "(.*?)" existuje$/ do |document_name|
  @document = Document.find_by_name(document_name)
  fail "document #{document_name} doesn't exists" if @document.nil?
end

Pokud /^jsem v editaci dokumentu "(.*?)"$/ do |document_name|
  step "dokument \"#{document_name}\" existuje"
  step 'jsem v sekci "administrace dokumentů"'
  step "kliknu na řádku u dokumentu \"#{document_name}\" na odkaz \"Upravit\""
end

Pokud /^přidávám nový dokument$/ do
  step 'jsem v sekci "administrace dokumentů"'
  step 'kliknu na odkaz "Přidat nový dokument"'
end
# When statements

# Then statements

Pak /^dokument "(.*?)" by měl být smazán$/ do |document_name|
  begin
    find("#documents").should_not have_content("#{document_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^dokument "(.*?)" by měl být (?:vytvořen|upraven)$/ do |document_name|
  find("#documents").should have_content("#{document_name}")
end

Pak /^dokument "(.*?)" by měl být přiřazen obchodu "(.*?)"$/ do |document_name, shop_name|
  Document.find_by_name(document_name).shops.pluck("name").should include(shop_name)
end

Pak /^dokument "(.*?)" by neměl být přiřazen obchodu "(.*?)"$/ do |document_name, shop_name|
  Document.find_by_name(document_name).shops.pluck("name").should_not include(shop_name)
end