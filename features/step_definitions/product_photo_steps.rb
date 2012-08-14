# encoding: UTF-8

Pokud /^upravuji produkt "(.*?)" a jsem na záložce "(.*?)"$/ do |product_name, tab|
  @product = Product.find_by_name(product_name)
  raise "product #{product_name} not found" if @product.nil?
  url = case tab
          when "Obrázky"
            admin_product_photos_path(@product)
          when "Parametry"
            admin_product_params_path(@product)
          else
            raise "tab #{tab} in editation of product is not known"
        end
  visit url
end

Pokud /^tento produkt nemá žádné dodatečné obrázky$/ do
  @product.photos.should be_empty
end

Pokud /^tento produkt má dodatečný obrázek "(.*?)", který je na (\d+)\. pozici$/ do |photo_title, position|
  photo = @product.photos.find_by_title(photo_title)
  photo.position.should == position.to_i
  photo.should_not be_main_photo
end

Pokud /^tento produkt má obrázek "(.*?)", který je (hlavní|dodatečný)$/ do |photo_title, photo_type|
  photo = @product.photos.find_by_title(photo_title)
  photo.should_not be_nil
  if photo_type == "hlavní"
    photo.should be_main_photo
  else
    photo.should_not be_main_photo
  end
end

Když /^vložím soubor "(.*?)" do pole "(.*?)"$/ do |filename, field|
  @image_to_upload = "features/resources/" + filename
  attach_file(field, @image_to_upload)
end

Když /^přesunu obrázek "(.*?)" na (\d+)\. pozici$/ do |photo_title, position|
  photo = @product.photos.find_by_title(photo_title)
  distance = position.to_i - photo.position
  simulate_drag_sortable(photo, distance)
end

Pak /^by měl produkt mít hlavní obrázek shodný s nahraným obrázkem$/ do
  @product.main_photo.image.path.should be_the_same_file_as(@image_to_upload)
end

Pak /^by měl produkt mít jeden dodatečný obrázek$/ do
  @product.additional_photos.size.should == 1

  # Keep it for optional subsequent steps
  @additional_photo = @product.additional_photos.first
end

Pak /^tento dodatečný obrázek by měl být shodný s nahraným obrázkem$/ do
  @additional_photo.image.path.should be_the_same_file_as(@image_to_upload)
end

Pak /^obrázek produktu "(.*?)" by měl být (hlavní|dodatečný)$/ do |photo_title, photo_type|
  photo = @product.photos.find_by_title(photo_title)
  photo.should_not be_nil
  if photo_type == "hlavní"
    photo.should be_main_photo
  else
    photo.should_not be_main_photo
  end
end


Pak /^obrázek "(.*?)" by měl být na (\d+)\. pozici$/ do |photo_title, position|
  photo = @product.photos.find_by_title(photo_title)
  photo.position.should == position.to_i
end