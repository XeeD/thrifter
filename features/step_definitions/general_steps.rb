# encoding: UTF-8

# Transforms

# Helpers
def find_table_row_with_text(line_text)
  row = all("table").find do |table|
    begin
      break table.find("tr", :text => line_text)
    rescue Capybara::ElementNotFound
      next false
    end
  end

  unless row
    raise "row with text #{line_text} not found"
  end

  row
end

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
  row = find_table_row_with_text(line_text)

  begin
    row.find("a", :text => link_title).click
  rescue Capybara::ElementNotFound
    raise "link with title #{link_title} not found on line '#{line_text}'"
  end
end

Když /^kliknu na tlačítko "(.*?)"$/ do |button|
  click_button button.to_s
end

Když /^změním hodnotu pole "(.*?)" na "(.*?)"$/ do |field, value|
  begin
    fill_in field, :with => value
  rescue Capybara::ElementNotFound
    raise
  end
end

Když /^vyplním "(.*?)" do pole "(.*?)"$/ do |value, field|
  fill_in field, :with => value
end

Když /^vyberu hodnotu "(.*?)" ze seznamu "(.*?)"$/ do |value, field|
  select value.to_s, :from => field.to_s
end

Když /^vyberu hodnoty "(.*?)" ze seznamu "(.*?)"$/ do |values, field|
  values.split(',').each do |value|
    select value.to_s.strip, :from => field.to_s
  end
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

Když /^zaškrtnu přepínač "(.+?)" pro vlastnost "(.+?)"$/ do |value, button_group|
  within_fieldset(button_group) do
    choose value.to_s
  end
end

Když /^zaškrtnu pole "(.+?)" pro vlastnost "(.+?)"$/ do |value, fieldset|
  within_fieldset(fieldset.to_s) do
    check value.to_s
  end
end

Když /^odškrtnu pole "(.*?)" pro vlastnost "(.+?)"$/ do |value, fieldset|
  within_fieldset(fieldset.to_s) do
    uncheck value.to_s
  end
end

# Then statements
Pak /^bych měl vidět zprávu "(.*?)"$/ do |message|
  find("#flash_messages .notice").should have_content(message)
end

Pak /^bych měl vidět (pod)?nadpis "(.*?)"$/ do |level, heading|
  heading_tag = case level
                  when "pod" then
                    "h3"
                  else
                    "h2"
                end
  find(heading_tag).should have_content(heading)
end

Pak /^(?:bych měl|měl bych) vidět "(.*?)"$/ do |heading|
  page.should have_content(heading)
end

Pak /^by pole "(.*?)" u vlastnosti "(.*?)" nemělo jít zaškrtnout$/ do |value, fieldset|
  within_fieldset(fieldset.to_s) do
    field_labeled(value.to_s)['disabled'].should == 'disabled'
  end
end