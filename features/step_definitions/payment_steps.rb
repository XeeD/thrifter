# encoding: UTF-8

# Given statements
Pokud /^typ platby "(.*?)" existuje$/ do |payment_method_name|
  @payment_method = PaymentMethod.find_by_name(payment_method_name)
  fail "payment method #{payment_method_name} doesn't exists" if @payment_method.nil?
end

Pokud /^jsem v editaci typu platby "(.*?)"$/ do |payment_method_name|
  step "typ platby \"#{payment_method_name}\" existuje"
  step 'jsem v sekci "administrace typů platby"'
  step "kliknu na řádku u typu platby \"#{payment_method_name}\" na odkaz \"Upravit\""
end

# When statements

# Then statements
Pak /^typ platby "(.*?)" by měl být smazán$/ do |payment_method_name|
  begin
    find("#payment_methods").should_not have_content("#{payment_method_name}")
  rescue Capybara::ElementNotFound
    page.should have_selector(".empty_set")
  end
end

Pak /^typ platby "(.*?)" by měl být (?:vytvořen|upraven)$/ do |payment_method_name|
  find("#payment_methods").should have_content("#{payment_method_name}")
end