# encoding: UTF-8

# Given statements
Pokud /^jsem přihlášený jako "(.*?)"$/ do |role|
  true
end

Pokud /^jsem v sekci "(.*?)"$/ do |section|
  visit(get_section_url(section))
end

Pokud /^existuje "(.*?)" "(.*?)"$/ do |model, identificator|
  pending
end

# When statements
Když /^kliknu na odkaz "(.*?)"$/ do |link|
  click_link "#{link}"
end

Když /^kliknu na tlačítko "(.*?)"$/ do |button|
  click_button "#{button}"
end

Když /^vyplním údaj "(.*?)" hodnotou "(.*?)"$/ do |field, value|
  fill_in "#{field}", :with => "#{value}"
end

Když /^otevřu sekci "(.*?)"$/ do |section|
  visit "#{get_section_url(section)}"
end

Když /^otevřu formulář "(.*?)"$/ do |form|
  visit "#{get_form_url(form)}"
end

Když /^změním hodnotu pole "(.*?)" na "(.*?)"$/ do |field, new_value|
  pending
end

Když /^vyplním formulář údaji:$/ do |form_values|
  form_values.hashes.each do |row|
    row.each_pair { |field, value| fill_in field, with: value }
  end
end

# Then statements
Pak /^bych měl vidět zprávu "(.*?)"$/ do |message|
  page.should have_content(message)
end

Pak /^bych měl vidět nadpis "(.*?)"$/ do |heading|
  find("h2").should have_content(heading)
end

Pak /^bych měl vidět seznam "(.*?)"$/ do |form|
  pending
end

