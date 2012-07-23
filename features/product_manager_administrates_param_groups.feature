# language: cs
Požadavek: Produktový manager spravuje kategorie

  Abych
  Jako produktový manager
  Chci mít možnost

  Kontext:
    Pokud jsem přihlášený jako "produktový manager"
    A šablona parametrů "Chladničky" existuje
    A jsem v sekci "administrace šablon parametrů"

  Scénář: zobrazení formuláře pro vytvoření nové skupiny parametrů
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    A kliknu na odkaz "Přidat novou skupinu parametrů"
    Pak bych měl vidět nadpis "Nová skupina parametrů v šabloně Chladničky"

  Scénář: přidání nové skupiny parametrů přes formulář
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    A kliknu na odkaz "Přidat novou skupinu parametrů"
    A vyplním "Rozměry" do pole "Název skupiny"
    A kliknu na tlačítko "Vytvořit novou skupinu parametrů"
    Pak bych měl vidět zprávu "Skupina parametrů Rozměry byla vytvořena"
    A skupina parameterů "Rozměry" by měla být vytvořena

  Scénář: smazání existující skupiny parametrů
    Pokud skupina parametrů "Funkce" existuje
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    Když kliknu na řádku u skupina parametrů "Funkce" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Skupina parametrů Funkce byla smazána"
    A skupina parametrů "Funkce" by měla být smazána

  Scénář: upravení existující skupiny parametrů
    Pokud skupina parametrů "Funkce" existuje
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    A kliknu na řádku u skupiny "Funkce" na odkaz "Upravit"
    A změním hodnotu pole "Název skupiny" na "Funkce a výbava"
    A kliknu na tlačítko "Uložit skupinu parametrů"
    Pak bych měl vidět zprávu "Skupina parametrů Funkce a výbava byla upravena"
    A skupina parametrů "Funkce a výbava" by měla být upravena

  Scénář: zobrazení existující skupiny parametrů v detailu šablony parametrů
    Pokud skupina parametrů "Funkce" existuje
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    Pak bych měl vidět "Funkce" v tabulce "Skupiny parametrů"

