# encoding: UTF-8

# Given statements
Pokud /^produkt "(.*?)" je náhradou současného produktu$/ do |replacement_name|
  replacement = Product.unscoped.find_by_name(replacement_name)
  @product.replacements.should include(replacement)
  @product.state.should.eql? "replaced"
end

# When statements

# Then statements
Pak /^produkt "(.*?)" by měl být náhradou současného produktu$/ do |replacement_name|
  @product.replacements.reload
  step "produkt \"#{replacement_name}\" je náhradou současného produktu"
end

Pak /^produkt "(.*?)" by neměl být náhradou současného produktu$/ do |replacement_name|
  @product.replacements.reload

  expect {
    step "produkt \"#{replacement_name}\" by měl být náhradou současného produktu"
  }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
end