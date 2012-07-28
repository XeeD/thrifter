# language: cs
Požadavek: Produktový admin upravuje obrázky k produktu

  Abych mohl zákazníkům umožnit prohlédnout si, jak produkt vypadá
  Jako produktový admin
  Chci mít možnost přidávat obrázky k produktu. Každý produkt může mít jeden hlavní
  obrázek a několik dalších dodatečných obrázků.

  Kontext:
    Pokud jsem přihlášený jako "produktový admin"

  Scénář: přidání hlavního obrázku k produktu
    Pokud upravuji produkt "LG GB3133TIJW" a jsem na záložce "Obrázky"
    Když vložím soubor "lg_gb3133tijw.jpg" do pole "Soubor s obrázkem"
    A zaškrtnu přepínač "Hlavní obrázek produktu" pro vlastnost "Typ obrázku"
    A kliknu na tlačítko "Přidat nový obrázek"
    Pak by měl produkt mít hlavní obrázek shodný s nahraným obrázkem

  @wip
  Scénář: přidání dodatečného obrázku k produktu
    Pokud upravuji produkt "LG GB3133TIJW" a jsem na záložce "Obrázky"
    A tento produkt nemá žádné dodatečné obrázky
    Když vložím soubor "lg_gb3133tijw_2.jpg" do pole "Soubor s obrázkem"
    A zaškrtnu přepínač "Dodatečný obrázek" pro vlastnost "Typ obrázku"
    A kliknu na tlačítko "Přidat nový obrázek"
    Pak by měl produkt mít jeden dodatečný obrázek
    A tento dodatečný obrázek by měl být shodný s nahraným obrázkem

  @wip
  Scénář: nastavení jiného hlavního obrázku pro produkt
    Pokud upravuji produkt "LG GB3133TIJW" a jsem na záložce "Obrázky"
    A tento produkt má obrázek "zavřená lednice", který je hlavní
    A tento produkt má obrázek "otevřená lednice", který je dodatečný
    A kliknu na řádku "otevřená lednice" na odkaz "Vybrat jako hlavní obrázek"
    Pak obrázek produktu "otevřená lednice" by měl být hlavní
    A obrázek produktu "zavřená lednice" by měl být dodatečný
