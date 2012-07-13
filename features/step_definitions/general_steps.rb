# encoding: UTF-8

#Given statements
Pokud /^jsem přihlášený jako "(.*?)"$/ do |role|
  pending
end

Pokud /^jsem v sekci "(.*?)"$/ do |section|
  pending
end

Pokud /^existuje "(.*?)" "(.*?)"$/ do |model, identificator|
  pending
end

#When statements
Když /^kliknu na odkaz "(.*?)"$/ do |link|
  click_link "#{link}"
end

Když /^kliknu na tlačítko "(.*?)"$/ do |button|
  click_button "#{button}"
end

Když /^vyplním údaj "(.*?)" hodnotou "(.*?)"$/ do |field, value|
  fill_in "#{key}", :with => "#{value}"
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

#Then statements
Pak /^bych měl vidět zprávu "(.*?)"$/ do |message|
  response.should contain("#{message}")
end

Pak /^bych měl vidět formulář "(.*?)"$/ do |form|
  pending
end

Pak /^bych měl vidět seznam "(.*?)"$/ do |form|
  pending
end