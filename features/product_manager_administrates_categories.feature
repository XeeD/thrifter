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
    A kliknu na tlačítko "Vytvořit novou kategorii"
    Pak bych měl vidět zprávu "Kategorie Pračky byla vytvořena"
    A kategorie "Pračky" by měla být vytvořena

  Scénář: smazání existující kategorie
    Pokud kategorie "Pračky" existuje
    A jsem v sekci "administrace kategorií"
    Když kliknu na odkaz "Smazat"
    Pak bych měl vidět zprávu "Kategorie Pračky byla smazána"
    A kategorie "Pračky" by měla být smazána

  Scénář: upravení existující kategorie
    Pokud jsem v editaci kategorie "Pračky"
    Pak bych měl vidět nadpis "Úprava kategorie Pračky"

  Scénář: upravení existující značky přes formulář
    Pokud jsem v editaci kategorie "Pračky"
    A vyplním formulář údaji:
      | Název    | Název v odkazu | Celý název (mn. č.) | Celý název (j. č.) |
      | Televize | televize       | Televize            | Televize           |
    A kliknu na tlačítko "Uložit"
    Pak bych měl vidět zprávu "Kategorie Televize byla upravena"
    A kategorie "Televize" by měla být upravena