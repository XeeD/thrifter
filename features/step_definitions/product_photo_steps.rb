# encoding: UTF-8

Pokud /^upravuji produkt "(.*?)" a jsem na záložce "(.*?)"$/ do |product_name, tab|
  @product = Product.find_by_name(product_name)
  raise "product #{product_name} not found" if @product.nil?
  url = case tab
          when "Obrázky"
            admin_product_photos_path(@product)
          else
            raise "tab #{tab} in editation of product is not known"
        end
  visit url
end

Pokud /^tento produkt nemá žádné dodatečné obrázky$/ do
  @product.photos.should be_empty
end

Když /^vložím soubor "(.*?)" do pole "(.*?)"$/ do |filename, field|
  @image_to_upload = "features/resources/" + filename
  attach_file(field, @image_to_upload)
end

Pak /^by měl produkt mít hlavní obrázek shodný s nahraným obrázkem$/ do
  @product.main_photo.image.path.should be_the_same_file_as(@image_to_upload)
end

Pak /^by měl produkt mít jeden dodatečný obrázek$/ do
  @product.additional_photos.size.should == 1
  @additional_photo = @product.additional_photos.first
end

Pak /^tento dodatečný obrázek by měl být shodný s nahraným obrázkem$/ do
  pending # express the regexp above with the code you wish you had
end