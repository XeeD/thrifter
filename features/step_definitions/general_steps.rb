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
  click_link link.to_s
end

Když /^kliknu na řádku u .+ "(.*?)" na odkaz "(.*?)"$/ do |line_text, link_title|
  raise "line not found" unless all("table").each do |table|
    begin
      row = table.find("tr", :text => line_text)
      link = row.find("a", :text => link_title)
      link.click
      save_page
      break true
    rescue Capybara::ElementNotFound
      next
    end
  end
end

Když /^kliknu na tlačítko "(.*?)"$/ do |button|
  click_button button.to_s
end

Když /^změním hodnotu pole "(.*?)" na "(.*?)"$/ do |field, value|
  fill_in field, :with => value
end

Když /^vyplním "(.*?)" do pole "(.*?)"$/ do |value, field|
  fill_in field, :with => value
end

Když /^vyberu hodnotu "(.*?)" ze seznamu "(.*?)"$/ do |value, field|
  select value.to_s, :from => field.to_s
end

Když /^otevřu sekci "(.*?)"$/ do |section|
  visit get_section_url(section).to_s
end

Když /^vyplním formulář údaji:$/ do |form_values|
  form_values.hashes.each do |row|
    row.each_pair { |field, value| fill_in field, with: value }
  end
end

Když /^pokračuji ve vyplňování formuláře:$/ do |form_values|
  step "vyplním formulář údaji:", form_values
end

Když /^zaškrtnu přepínač "(.*?)" pro vlastnost "(.*?)"$/ do |value, button_group|
  within_fieldset(button_group) do
    choose(value)
  end
end

# Then statements
Pak /^bych měl vidět zprávu "(.*?)"$/ do |message|
  find("#flash_messages .notice").should have_content(message)
end

Pak /^bych měl vidět (pod)?nadpis "(.*?)"$/ do |level, heading|
  heading_tag = case level
    when "pod" then "h3"
    else "h2"
  end
  find(heading_tag).should have_content(heading)
end

Pak /^(?:bych měl|měl bych) vidět "(.*?)"$/ do |heading|
  page.should have_content(heading)
end
