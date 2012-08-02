# encoding: UTF-8

# Given statements
Pokud /^existuje produkt "(.*?)"$/ do |product_name|
  @product = Product.find_by_name(product_name)
  fail "product #{product_name} doesn't exists" if @product.nil?
end

Pokud /^jsem v editace produktu "(.*?)" na záložce "(.*?)"$/ do |product_name, tab_name|
  @product = Product.find_by_name(product_name)
  @product.should_not be_nil

  visit case tab_name.strip
          when "Kategorie"
            admin_product_categorizations_path(@product)
          else
            raise "tab '#{tab_name}' is not known"
        end
end

# When statements

# Then statements
Pak /^produkt "(.*?)" by měl být smazán$/ do |name|
  begin
    find("#products").should_not have_content("#{name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^produkt "(.*?)" by měl být (?:vytvořen|upraven)$/ do |name|
  find("#products").should have_content("#{name}")
end