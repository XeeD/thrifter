# language: cs
Požadavek: Produktový manager spravuje značky

  Abych mohl spravovat značky
  Jako produktový manager
  Chci mít možnost jejich snadné administrace

  Kontext:
    Pokud jsem přihlášený jako "produktový manager"

  Scénář: vytvoření nové značky
    Když otevřu sekci "administrace značek"
    A kliknu na odkaz "Přidat novou značku"
    Pak bych měl vidět nadpis "Nová značka"

  Scénář: přidání nové značky přes formulář
    Pokud jsem v sekci "administrace značek"
    Když kliknu na odkaz "Přidat novou značku"
    A vyplním formulář údaji:
      | Název | Název v odkazu | Popis          |
      | LG    | lg             | LG Electronics |
    A kliknu na tlačítko "Vytvořit novou značku"
    Pak bych měl vidět zprávu "Značka LG byla vytvořena"
    A značka "LG" by měla být vytvořena

  Scénář: smazání existující značky
    Pokud značka "LG" existuje
    A jsem v sekci "administrace značek"
    Když kliknu na odkaz "Smazat"
    Pak bych měl vidět zprávu "Značka LG byla smazána"
    A značka "LG" by měla být smazána

  Scénář: upravení existující značky
    Pokud jsem v editaci značky "LG"
    Pak bych měl vidět nadpis "Úprava značky LG"

  Scénář: upravení existující značky přes formulář
    Pokud jsem v editaci značky "LG"
    A vyplním formulář údaji:
      | Název   | Název v odkazu | Popis    |
      | Samsung | samsung        | Samsung  |
    A kliknu na tlačítko "Uložit značku"
    Pak bych měl vidět zprávu "Značka Samsung byla upravena"
    A značka "Samsung" by měla být upravena
