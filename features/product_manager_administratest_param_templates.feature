# language: cs
Požadavek: Produktový manager spravuje kategorie

  Abych přiřazovat produtkům jejich parametry, potřebuji mít možnost nejdříve možnost
  zjistit, jaké parametry daný produkt může mít. Jelikož některé kategorie produktů sdílí
  své parametry, je třeba můžeme definovat pro tyto kategorie jednu "šablonu parametrů".
  Jako produktový manager
  Chci mít možnost vytvářet "šablony parametrů". Ta je seskupením parametrů, které
  je možné přiřadit jednotlivým produktovým kategoriím.

  Kontext:
    Pokud jsem přihlášený jako "produktový manager"
    A navigační kategorie "Chladničky" existuje
    A produktová kategorie "Americké chladničky" existuje
    A produktová kategorie "Kombinované chladničky" existuje
    A dodatečná kategorie "Kombinované chladničky s mrazákem nahoře" existuje
    A dodatečná kategorie "Kombinované chladničky s mrazákem dole" existuje

  Scénář: zobrazení formuláře pro vytvoření nové šablony parametrů
    Když otevřu sekci "administrace šablon parametrů"
    A kliknu na odkaz "Přidat novou šablonu parametrů"
    Pak bych měl vidět nadpis "Nová šablona parametrů"

  Scénář: přidání nové šablony parametrů přes formulář
    Pokud jsem v sekci "administrace šablon parametrů"
    Když kliknu na odkaz "Přidat novou šablonu parametrů"
    A vyplním "Chladničky" do pole "Název šablony"
    A kliknu na tlačítko "Vytvořit novou šablonu parametrů"
    Pak bych měl vidět zprávu "Šablona parametrů Chladničky byla vytvořena"
    A šablona parameterů "Chladničky" by měla být vytvořena

  Scénář: přiřazení nové šablony dané kategorii při vytváření
    Pokud jsem v sekci "administrace šablon parametrů"
    Když kliknu na odkaz "Přidat novou šablonu parametrů"
    A vyplním "Chladničky" do pole "Název šablony"
    A zaškrtnu pole "Kombinované chladničky" pro vlasnost "Přiřazené kategorie"
    A kliknu na tlačítko "Vytvořit novou šablonu parametrů"
    Pak kategorie "Kombinované chladničky" by měla mít šablonu parametrů "Chladničky"
    Ale kategorie "Americké chladničky" by neměla mít šablonu parametrů "Chladničky"

  Scénář: smazání existující šablony parametrů
    Pokud jsem v sekci "administrace šablon parametrů"
    Když kliknu na řádku u šablony parametrů "Chladničky" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Šablona parametrů Chladničky byla smazána"
    A šablona parametrů "Chladničky" by měla být smazána

  Scénář: upravení existující šablony parametrů
    Pokud jsem v sekci "administrace šablon parametrů"
    Když kliknu na řádku u šablony "Chladničky" na odkaz "Upravit"
    A změním hodnotu pole "Název" na "Lednice"
    A kliknu na tlačítko "Uložit šablonu parametrů"
    Pak bych měl vidět zprávu "Šablona parametrů Lednice byla upravena"
    A šqblona parametrů "Lednice" by měla být upravena

  Scénář: přiřazení existující šablony parametrů jiné kategorii
    Pokud jsem v sekci "administrace šablon parametrů"
    A šablona parametrů "Chladničky" existuje a je přiřazena kategorii "Americké chladničky"
    Když kliknu na řádku u šablony "Chladničky" na odkaz "Upravit"
    A zaškrtnu pole "Kombinované chladničky" pro vlasnost "Přiřazené kategorie"
    A kliknu na tlačítko "Uložit šablonu parametrů"
    Pak kategorie "Kombinované chladničky" by měla mít šablonu parametrů "Chladničky"
    Ale kategorie "Americké chladničky" by neměla mít šablonu parametrů "Chladničky"

  Scénář: šablona parametrů nelze přiřadit kategorii s již přiřazenou šablonou
    Pokud jsem v sekci "administrace šablon parametrů"
    A šablona parametrů "Chladničky" existuje a je přiřazena kategorii "Americké chladničky"
    Když kliknu na řádku u šablony "Chladničky" na odkaz "Upravit"
    Pak by pole "Americké chladničky" u vlastnosti "Přiřazené kategorie" nemělo jít zaškrtnout