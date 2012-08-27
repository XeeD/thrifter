# language: cs
Požadavek: Produktový manager spravuje značky

  Abych mohl v e-shopu zobrazit značky jednotlivých produktů
  Jako produktový manager
  Chci mít možnost jejich snadné administrace.
  Systém mi musí v administraci umožnit jednotlivé značky vytvářet, upravovat a mazat.

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
      | Název      | Název v odkazu      | Popis               |
      | Samsung    | samsung             | Samsung Electronics |
    A kliknu na tlačítko "Vytvořit novou značku"
    Pak bych měl vidět zprávu "Značka Samsung byla vytvořena"
    A značka "Samsung" by měla být vytvořena

  Scénář: smazání existující značky
    Pokud značka "Indesit" existuje
    A jsem v sekci "administrace značek"
    Když kliknu na řádku u značky "Indesit" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Značka Indesit byla smazána"
    A značka "Indesit" by měla být smazána

  Scénář: upravení existující značky
    Pokud jsem v editaci značky "Indesit"
    Pak bych měl vidět nadpis "Úprava značky Indesit"

  Scénář: upravení existující značky přes formulář
    Pokud jsem v editaci značky "Indesit"
    A vyplním formulář údaji:
      | Název   | Název v odkazu | Popis              |
      | Sharp   | sharp          | Sharp Electronics  |
    A kliknu na tlačítko "Uložit značku"
    Pak bych měl vidět zprávu "Značka Sharp byla upravena"
    A značka "Sharp" by měla být upravena
