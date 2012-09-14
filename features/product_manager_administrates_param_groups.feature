# language: cs
Požadavek: Produktový manager spravuje skupiny parametrů

  Abych mohl seřadit zpřehlednil zobrazení parametrů výrobku především pro zákazníky e-shopu
  Jako produktový manager
  Chci mít možnost seskupit spolu související parametry do skupin. Tyto skupiny budu vytvářet
  pod jednotlivými šablonami parametrů.

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
    A vyplním "Spotřeba" do pole "Název skupiny"
    A kliknu na tlačítko "Vytvořit novou skupinu parametrů"
    Pak bych měl vidět zprávu "Skupina parametrů Spotřeba byla vytvořena"
    A skupina parametrů "Spotřeba" by měla být vytvořena

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
    Pak bych měl vidět v tabulce Skupiny parametrů řádek "Funkce"

  @javascript
  Scénář: změna pořadí skupin parametrů
    Pokud skupina parametrů "Funkce" existuje a je 1. v pořadí
    A skupina parametrů "Rozměry" existuje a je 2. v pořadí
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    A přesunu řádek skupiny "Rozměry" o 1 pozici nahoru
    Pak skupina "Rozměry" by měla být 1. v pořadí
    A skupina "Funkce" by měla být 2. v pořadí
