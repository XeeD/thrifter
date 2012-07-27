# language: cs
Požadavek: Produktový admin upravuje obrázky k produktu

  Abych mohl zákazníkům umožnit prohlédnout si, jak produkt vypadá
  Jako produktový admin
  Chci mít možnost přidávat obrázky k produktu. Každý produkt může mít jeden hlavní
  obrázek a několik dalších dodatečných obrázků.

  Kontext:
    Pokud jsem přihlášený jako "produktový admin"

  Scénář: přidání hlavního obrázku k produktu
    Pokud upravuji produkt "LG GB3133TIJW"
    A začnu vyplňovat formulář "Obrázky"
    A vložím soubor "LG_GB3133TIJW.jpg" do pole "Soubor s obrázkem"
    A zaškrtnu přepínač "hlavní obrázek" pro vlastnost "Typ obrázku"
    Když kliknu na tlačítko "Nahrát soubor"
    Pak by měl produkt mít hlavní obrázek shodný s nahraným obrázkem

  Scénář: přidání dodatečného obrázku k produktu
    Pokud upravuji produkt "LG GB3133TIJW"
    A tento produkt nemá žádné dodatečné obrázky
    A začnu vyplňovat formulář "Obrázky"
    A vložím soubor "LG_GB3133TIJW_2.jpg" do pole "Soubor s obrázkem"
    A zaškrtnu přepínač "dodatečný obrázek" pro vlastnost "Typ obrázku"
    Když kliknu na tlačítko "Nahrát soubor"
    Pak by měl produkt mít jeden dodatečný obrázek
    A tento dodatečný obrázek by měl být shodný s nahraným obrázkem

  Scénář: nastavení jiného hlavního obrázku pro produkt
    Pokud upravuji produkt "LG GB3133TIJW"
    A tento produkt má obrázek "zavřená lednice", který je hlavní
    A tento produkt má obrázek "otevřená lednice", který je dodatečný
    A kliknu na řádku "otevřená lednice" na odkaz "Vybrat jako hlavní obrázek"
    Pak obrázek produktu "otevřená lednice" by měl být hlavní
    A obrázek produktu "zavřená lednice" by měl být dodatečný
