# encoding: UTF-8

#Given states
Pokud /^jsem přihlášený jako "(.*?)"$/ do |role|
  pending
end

Pokud /^jsem v sekci "(.*?)"$/ do |section|
  pending
end

Pokud /^existuje "(.*?)" "(.*?)"$/ do |model, identificator|
  pending
end

#When states
Když /^kliknu na odkaz "(.*?)"$/ do |link|
  click_link "#{link}"
end

Když /^kliknu na tlačítko "(.*?)"$/ do |button|
  click_button "#{button}"
end

Když /^vyplním údaj "(.*?)" hodnotou "(.*?)"$/ do |key, value|
  fill_in "#{key}", :with => "#{value}"
end

Když /^otevřu sekci "(.*?)"$/ do |section|
  visit "#{get_section_url(section)}"
end

Když /^otevřu formulář "(.*?)"$/ do |form|
  pending
  #visit "#{get_form_url(form)}"
end

#Then states
Pak /^bych měl vidět zprávu "(.*?)"$/ do |message|
  response.should contain("#{message}")
end

Pak /^bych měl vidět formulář "(.*?)"$/ do |form|
  pending
end

Pak /^bych měl vidět seznam "(.*?)"$/ do |form|
  pending
end