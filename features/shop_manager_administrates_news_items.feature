# language: cs
Požadavek: Manager obchodu spravuje novinky

  Abych mohl prezentovat novinky pro jednotlivé obchody
  Jako správce obchodů
  Chci mít možnost jednotlivým obchodům přidávat a upravovat jejich aktuality.

  Kontext:
    Pokud jsem přihlášený jako "manager obchodu"
    A novinka "ShopDesetiletí" v obchodu "Spořílek.cz" existuje

  Scénář: vypsání všech novinek z jednoho obchodu
    Když otevřu sekci "administrace novinek"
    A kliknu na odkaz "Spořílek.cz"
    Pak bych měl vidět "Novinky v obchodu Spořílek.cz"
    A měl bych vidět "ShopDesetiletí"

  Scénář: vytvoření nové novinky
    Pokud mám otevřenou administraci novinek pro obchod "Spořílek.cz"
    Když kliknu na odkaz "Přidat novinku"
    A vyplním formulář údaji:
    | Nadpis   | Obsah                | Kontextový odkaz         |
    | ShopRoku | Spořílek je ShopRoku | www.shoproku.cz/vysledky |
    A kliknu na tlačítko "Vytvořit novinku"
    Pak bych měl vidět zprávu "Novinka ShopRoku byla vytvořena"
    A novinka "ShopRoku" by měla být vytvořena

  Scénář: smazání existující kategorie
    Pokud mám otevřenou administraci novinek pro obchod "Spořílek.cz"
    Když kliknu na řádku u novinky "ShopDesetiletí" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Novinka ShopDesetiletí byla smazána"
    A novinka "ShopDesetiletí" by měla být smazána

  Scénář: upravení existující kategorie
    Pokud mám otevřenou administraci novinek pro obchod "Spořílek.cz"
    A kliknu na řádku u novinky "ShopDesetiletí" na odkaz "Upravit"
    A změním hodnotu pole "Nadpis" na "ShopRoku"
    Když kliknu na tlačítko "Uložit novinku"
    Pak bych měl vidět zprávu "Novinka ShopRoku byla upravena"
    A novinka "ShopRoku" by měla být upravena