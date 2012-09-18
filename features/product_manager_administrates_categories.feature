# language: cs
Požadavek: Produktový manager spravuje kategorie

  Abych mohl třídit produkty do různých kategorií, musím mít možnost tento seznam
  kategorií spravovat.
  Jako produktový manager
  Chci mít možnost jednoduchého přidávání, přesouvání, upravování a mazání kategorií

  Kontext:
    Pokud jsem přihlášený jako "produktový manager"
    A kategorie "Chladničky" v obchodu "Spořílek.cz" existuje

  Scénář: vypsání všech kategorií z jednoho obchodu
    Když otevřu sekci "administrace kategorií"
    A kliknu na odkaz "Spořílek.cz"
    Pak bych měl vidět "Kategorie v obchodu Spořílek.cz"
    A měl bych vidět "Chladničky"

  Scénář: vytvoření nové kategorie
    Pokud mám otevřenou administraci kategorií pro obchod "Spořílek.cz"
    Když kliknu na odkaz "Přidat novou kategorii"
    A vyplním formulář údaji:
      | Název          | Název v odkazu | Celý název (mn. č.) | Celý název (j. č.) |
      | Malé ledničky  |  male-lednicky | Malé ledničky       | Malá lednička      |
    A vyberu hodnotu "Navigační" ze seznamu "Typ kategorie"
    A zaškrtnu přepínač "Chladničky" pro vlastnost "Nadřazená kategorie"
    A kliknu na tlačítko "Vytvořit novou kategorii"
    Pak bych měl vidět zprávu "Kategorie Malé ledničky byla vytvořena"
    A kategorie "Malé ledničky" by měla být vytvořena

  Scénář: smazání existující kategorie
    Pokud kategorie "Kombinované chladničky" v obchodu "Spořílek.cz" existuje
    Pokud mám otevřenou administraci kategorií pro obchod "Spořílek.cz"
    Když kliknu na řádku u kategorie "Kombinované chladničky" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Kategorie Kombinované chladničky byla smazána"
    A kategorie "Kombinované chladničky" by měla být smazána

  Scénář: upravení existující kategorie
    Pokud mám otevřenou administraci kategorií pro obchod "Spořílek.cz"
    A kliknu na řádku u kategorie "Chladničky" na odkaz "Upravit"
    A změním hodnotu pole "Celý název (mn. č.)" na "Lednice"
    A kliknu na tlačítko "Uložit kategorii"
    Pak bych měl vidět zprávu "Kategorie Lednice byla upravena"
    A kategorie "Lednice" by měla být upravena

  @javascript
  Scénář: Kontrola návrhu URL adresy z názvu kategorie
    Pokud přidávám novou kategorii pro obchod "Spořílek.cz"
    Když vyplním "Americké chladničky" do pole "Název"
    Pak hodnota pole "Název v odkazu" by měla být "americke-chladnicky"