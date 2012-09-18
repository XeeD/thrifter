# encoding: UTF-8

# Given statements
Pokud /^vložím do košíku produkt "(.*?)"$/ do |product_name|
  step "jsem v detailu produktu \"#{product_name}\""
  step 'kliknu na tlačítko "Vložit do košíku"'
  step "bych měl vidět \"Zboží #{product_name} bylo vloženo do košíku\""
end

# When statements
Když /^změním hodnotu množství na řádku u produktu "(.*?)"$/ do |line_text|
  row = find_table_row_with_text(line_text)

  begin
    row.find('//input').fill_in "1"
  rescue Capybara::ElementNotFound
    raise "link with title #{link_title} not found on line '#{line_text}'"
  end
end

# Then statements