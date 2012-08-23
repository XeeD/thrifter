# encoding: UTF-8

MenuBuilder::Builder.build do
  menu :admin do
    group "Produkty" do
      item :products, title: "Produkty" do
        tab :photos
        tab :param_items
        tab :replacements
      end
      item :brands, title: "Značky"
    end

    group "Parametry", prefix: :param do
      item :templates, title: "Šablony parametrů"
    end

    group "Texty" do
      item :news_items, title: "Novinky"
      item :documents, title: "Dokumenty"
    end

    group "Nastavení" do
      item :shops, title: "Obchody"
      item :categories, title: "Kategorie"
    end
  end
end