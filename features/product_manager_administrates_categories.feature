# language: cs
Požadavek: Produktový manager spravuje kategorie

  Abych mohl spravovat kategorie
  Jako produktový manager
  Chci mít možnost jednoduchého přidávání, přesouvání, upravování a mazání kategorií

  Kontext:
    Pokud jsem přihlášený jako "produktový manager"

  Scénář: vytvoření nové kategorie
    Když otevřu sekci "administrace kategorií"
    A kliknu na odkaz "Přidat novou kategorii"
    Pak bych měl vidět nadpis "Nová kategorie"

  Scénář: přidání nové kategorie přes formulář
    Pokud jsem v sekci "administrace kategorií"
    Když kliknu na odkaz "Přidat novou kategorii"
    A vyplním formulář údaji:
      | Název   | Název v odkazu | Celý název (mn. č.) | Celý název (j. č.) |
      | Pračky  | pracky         | Pračky              | Pračka             |
    A vyberu hodnotu "Navigační" ze seznamu "Typ kategorie"
    A kliknu na tlačítko "Vytvořit novou kategorii"
    Pak bych měl vidět zprávu "Kategorie Pračky byla vytvořena"
    A kategorie "Pračky" by měla být vytvořena

  Scénář: smazání existující kategorie
    Pokud kategorie "LCD Televize" existuje
    A jsem v sekci "administrace kategorií"
    Když kliknu na odkaz "Smazat"
    Pak bych měl vidět zprávu "Kategorie LCD Televize byla smazána"
    A kategorie "LCD Televize" by měla být smazána

  Scénář: upravení existující kategorie
    Pokud jsem v editaci kategorie "LCD Televize"
    Pak bych měl vidět nadpis "Úprava kategorie LCD Televize"

  Scénář: upravení existující značky přes formulář
    Pokud jsem v editaci kategorie "LCD Televize"
    A vyplním formulář údaji:
      | Název    | Název v odkazu | Celý název (mn. č.) | Celý název (j. č.) |
      | Televize | televize       | Televize            | Televize           |
    A vyberu hodnotu "Produktová" ze seznamu "Typ kategorie"
    A kliknu na tlačítko "Uložit kategorii"
    Pak bych měl vidět zprávu "Kategorie Televize byla upravena"
    A kategorie "Televize" by měla být upravena