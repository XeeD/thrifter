# language: cs
Požadavek: Produktový manager spravuje kategorie

  Abych mohl třídit produkty do různých kategorií, musím mít možnost tento seznam
  kategorií spravovat.
  Jako produktový manager
  Chci mít možnost jednoduchého přidávání, přesouvání, upravování a mazání kategorií

  Kontext:
    Pokud jsem přihlášený jako "produktový manager"
    A kategorie "Chladničky" existuje

  Scénář: vytvoření nové kategorie
    Když otevřu sekci "administrace kategorií"
    A kliknu na odkaz "Přidat novou kategorii"
    Pak bych měl vidět nadpis "Nová kategorie"

  Scénář: přidání nové kategorie přes formulář
    Pokud jsem v sekci "administrace kategorií"
    Když kliknu na odkaz "Přidat novou kategorii"
    A vyplním formulář údaji:
      | Název          | Název v odkazu        | Celý název (mn. č.)    | Celý název (j. č.)     |
      | Kombinované  |  kombinované chladničky | Kombinované chladničky | Kombinovaná chladnička |
    A vyberu hodnotu "Navigační" ze seznamu "Typ kategorie"
    A zaškrtnu přepínač "Chladničky" pro vlastnost "Nadřazená kategorie"
    A kliknu na tlačítko "Vytvořit novou kategorii"
    Pak bych měl vidět zprávu "Kategorie Kombinované chladničky byla vytvořena"
    A kategorie "Kombinované chladničky" by měla být vytvořena

  Scénář: smazání existující kategorie
    Pokud jsem v sekci "administrace kategorií"
    Když kliknu na řádku u kategorie "Chladničky" na odkaz "Editovat"
    Pak bych měl vidět zprávu "Kategorie Chladničky byla smazána"
    A kategorie "Chladničky" by měla být smazána

  Scénář: upravení existující kategorie
    Pokud jsem v sekci "administrace kategorií"
    A kliknu na řádku u kategorie "Chladničky" na odkaz "Editovat"
    A změním hodnotu pole "Název" na "Lednice"
    A kliknu na tlačítko "Uložit kategorii"
    Pak bych měl vidět zprávu "Kategorie Lednice byla upravena"
    A kategorie "Lednice" by měla být upravena