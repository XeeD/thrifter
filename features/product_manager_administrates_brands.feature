# language: cs
Požadavek: Produktový manager spravuje značky

  Abych mohl spravovat značky
  Jako produktový manager
  Chci mít možnost

  Kontext:
    Pokud jsem přihlášený jako "produktový manager"
  Scénář: vytvoření nové značky
    Když otevřu sekci "administrace značek"
    A kliknu na odkaz "Přidat novou značku"
    Pak bych měl vidět formulář "přidání nové značky"

  Scénář: přidání nové značky přes formulář
    A jsem v sekci "administrace značek"
    Když otevřu formulář "přidání nové značky"
    A vyplním údaj "název" hodnotou "LG"
    A kliknu na tlačítko "Přidat značku"
    Pak bych měl vidět zprávu "Značka LG byla vytvořena"
    A značka "LG" by měla být vytvořena

  Scénář: smazání existující značky
    A jsem v sekci "administrace značek"
    A existuje "značka" "LG"
    Když otevřu sekci "administraci značek"
    A kliknu na odkaz "Smazat"
    Pak bych měl vidět zprávu "Značka LG byla smazána"
    A značka "LG" by měla být smazána