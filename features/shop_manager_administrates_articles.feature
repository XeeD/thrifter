# language: cs
@wip
Požadavek: Manager obchodu spravuje články kategorií

  Abych mohl prezentovat články pro jednotlivé obchody a jejich kategorie
  Jako správce obchodů
  Chci mít možnost přidávat a upravovat články pro kategorie v jednotlivých obchodech

  Kontext:
    Pokud jsem přihlášený jako "manager obchodu"
    A článek "LCD TV" v obchodu "Spořílek.cz" existuje

#  Scénář: vypsání všech novinek z jednoho obchodu
#    Když otevřu sekci "administrace novinek"
#    A kliknu na odkaz "Spořílek.cz"
#    Pak bych měl vidět "Novinky v obchodu Spořílek.cz"
#    A měl bych vidět "ShopDesetiletí"
#  Scénář: vytvoření nové novinky
#    Pokud mám otevřenou administraci novinek pro obchod "Spořílek.cz"
#    Když kliknu na odkaz "Přidat novinku"
#    A vyplním formulář údaji:
#      | Nadpis   | Obsah                | Kontextový odkaz         |
#      | ShopRoku | Spořílek je ShopRoku | www.shoproku.cz/vysledky |
#    A kliknu na tlačítko "Vytvořit novinku"
#    Pak bych měl vidět zprávu "Novinka ShopRoku byla vytvořena"
#    A novinka "ShopRoku" by měla být vytvořena
#
#  Scénář: smazání existující kategorie
#    Pokud novinka "ShopDesetiletí" v obchodu "Spořílek.cz" existuje
#    A mám otevřenou administraci novinek pro obchod "Spořílek.cz"
#    Když kliknu na řádku u novinky "ShopDesetiletí" na odkaz "Smazat"
#    Pak bych měl vidět zprávu "Novinka ShopDesetiletí byla smazána"
#    A novinka "ShopDesetiletí" by měla být smazána
#
#  Scénář: upravení existující kategorie
#    Pokud mám otevřenou administraci novinek pro obchod "Spořílek.cz"
#    A kliknu na řádku u novinky "ShopDesetiletí" na odkaz "Upravit"
#    A změním hodnotu pole "Nadpis" na "ShopRoku"
#    Když kliknu na tlačítko "Uložit novinku"
#    Pak bych měl vidět zprávu "Novinka ShopRoku byla upravena"
#    A novinka "ShopRoku" by měla být upravena