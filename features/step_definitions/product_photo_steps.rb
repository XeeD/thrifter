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

Když /^vložím soubor "(.*?)" do pole "(.*?)"$/ do |filename, field|
  @image_to_upload = "features/resources/" + filename
  attach_file(field, @image_to_upload)
end

Pak /^by měl produkt mít hlavní obrázek shodný s nahraným obrázkem$/ do
  save_page
  Rails.logger.debug(@product.main_photo.inspect)
  uploaded_image_size = File.size(@product.main_photo.image.path)
  original_image_size = File.size(@image_to_upload)
  uploaded_image_size.should == original_image_size
end