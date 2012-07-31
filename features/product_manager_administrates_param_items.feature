# language: cs
Požadavek: Produktový manager spravuje parametry

  Abych
  Jako produktový manager
  Chci mít možnost

  Kontext:
    Pokud jsem přihlášený jako "produktový manger"
    A šablona parametrů "Chladničky" existuje
    A jsem v sekci "administrace šablon parametrů"
    
  Scénář: zobrazení formuláře pro vytvoření nového parametru
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    A kliknu na odkaz "Přidat nový parametr"
    Pak bych měl vidět nadpis "Nový parametr"

  Scénář: přidání nového parametru přes formulář
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    A kliknu na odkaz "Přidat nový parametr"
    A vyplním "Funkce a výbava" do pole "Název parametru"
    A kliknu na tlačítko "Vytvořit nový parametr"
    Pak bych měl vidět zprávu "Parametr Funkce a výbava byl vytvořen"
    A parametr "Funkce a výbava" by měl být vytvořen

  Scénář: smazání existujícího parametru
    Pokud parametr "Šířka" existuje
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    Když kliknu na řádku u parametru "Šířka" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Parametr Šířka byl smazán"
    A parametr "Šířka" by měl být smazán

  Scénář: upravení existujícího parametru
    Pokud parametr "Šířka" existuje
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    A kliknu na řádku u parametru "Šířka" na odkaz "Upravit"
    A změním hodnotu pole "Název parametru" na "Tloušťka"
    A kliknu na tlačítko "Uložit parametr"
    Pak bych měl vidět zprávu "Parametr Tloušťka byl upraven"
    A parametr "Tloušťka" by měl být upraven

  Scénář: zobrazení existujícího parametru v detailu šablony parametrů
    Pokud parametr "Šířka" existuje
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Zobrazit"
    Pak bych měl vidět v tabulce Parametrů řádek "Šířka"