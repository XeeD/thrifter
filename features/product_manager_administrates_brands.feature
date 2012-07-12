# language: cs
Požadavek: Produktový manager spravuje značky

  Abych mohl spravovat značky
  Jako produktový manager
  Chci mít možnost

  Scénář: vytvoření nové značky
    Pokud jsem přihlášený jako "produktový manager"
    Když otevřu "administraci značek"
    A kliknu na odkaz "Přidat novou značku"
    Pak bych měl vidět formulář pro přidání nové značky

  Scénář: přidání nové značky přes formulář
    Pokud jsem přihlášený jako "produktový manager"
    Když otevřu formulář pro přidání nové značky
    A vyplním údaje pro značku "LG"
    A kliknu na tlaítko "Přidat značku"
    Pak bych měl vidět zprávu "Značka LG byla vytvořena"
    A značka "LG" by měla být vytvořena

  Scénář: smazání existující značky
    Pokud jsem přihlášený jako produktový manager
    A následující značka existuje:
      |name|
      |LG|
    Když otevřu "administraci značek"
    A kliknu na odkaz "Smazat"
    Pak bych měl vidět zprávu "Značka LG byla smazána"
    A značka "LG" by měla být smazána