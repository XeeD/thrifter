# language: cs
Požadavek: Manager obchodu spravuje způsoby dopravy

  Abych mohl spravovat jednotlivé metody dopravy
  Jako správce obchodů
  Chci mít možnost k jednotlivým obchodům přidávat způsoby dopravy a následně je upravovat

  Kontext:
    Pokud jsem přihlášený jako "manager obchodu"
    A obchod "Spořílek.cz" existuje

  Scénář: vypsání všech způsobů dopravy
    Když otevřu sekci "administrace typů dopravy"
    Pak bych měl vidět nadpis "Typy dopravy"

  Scénář: přidání nového způsobu dopravy
    Pokud jsem v sekci "administrace typů dopravy"
    Když kliknu na odkaz "Přidat nový typ dopravy"
    A vyplním formulář údaji:
      | Název               | Zdarma od | Stručný popis             | Úplný popis                              |
      | Standardní doručení | 2000      | Doporučený způsob dopravy | Pokud nebudete zastiženi, balík nedostanete |
    A pokračuji ve vyplňování části formuláře "Cézar":
      | Způsob dopravy | Přepravce |
      | 6              | DPD, DHL  |
    A zaškrtnu pole "Spořílek.cz" pro vlastnost "Přiřazení k obchodům"
    A zaškrtnu pole "Na splátky" pro vlastnost "Přiřazení k typům placení"
    A pokračuji ve vyplňování části formuláře "Možné velikosti balíků":
      | Váha od | Váha do | Cena |
      | 0       | 20      | 120  |
    A kliknu na tlačítko "Vytvořit nový typ dopravy"
    Pak bych měl vidět zprávu "Typ dopravy Standardní doručení byl vytvořen"
    A typ dopravy "Standardní doručení" by měl být vytvořen

  Scénář: smazání existujícího způsobu dopravy
    Pokud jsem v sekci "administrace typů dopravy"
    Když kliknu na řádku u typu dopravy "PPL" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Typ dopravy PPL byl smazán"
    A typ dopravy "PPL" by měl být smazán

  Scénář: upravení existujícího způsobu dopravy
    Pokud jsem v editaci typu dopravy "PPL"
    A změním hodnotu pole "Název" na "Standardní doručení"
    Když kliknu na tlačítko "Uložit typ dopravy"
    Pak bych měl vidět zprávu "Typ dopravy Standardní doručení byl upraven"
    A typ dopravy "Standardní doručení" by měl být upraven

  @wip @javascript
  Scénář: přidání nového balíku u existujícího způsobu dopravy
    Pokud jsem v editaci typu dopravy "PPL"

  @javascript
  Scénář: smazání existujícího balíku u existujícího způsobu dopravy
    Pokud jsem v editaci typu dopravy "PPL"
    A počet balíků u této dopravy je "2"
    Když kliknu na odkaz "X"
    Pak počet balíků u této dopravy je "1"

  @javascript
  Scénář: změna pořadí způsobů dopravy
    Pokud typ dopravy "PPL" existuje a je 1. v pořadí
    A typ dopravy "DPD" existuje a je 2. v pořadí
    Když otevřu sekci "administrace typů dopravy"
    A přesunu řádek typu dopravy "PPL" o 1 pozici nahoru
    Pak typ dopravy "DPD" by měl být 1. v pořadí
    A typ dopravy "PPL" by měl být 2. v pořadí

