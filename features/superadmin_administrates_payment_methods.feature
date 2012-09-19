# language: cs
Požadavek: Manager obchodu spravuje způsoby platby

  Abych mohl spravovat jednotlivé metody pro placení zboží zákazníkem
  Jako správce obchodů
  Chci mít možnost k jednotlivým obchodům přidávat způsoby placení a následně je upravovat

  Kontext:
    Pokud jsem přihlášený jako "manager obchodu"
    A obchod "Spořílek.cz" existuje

  Scénář: vypsání všech způsobů platby
    Když otevřu sekci "administrace typů platby"
    Pak bych měl vidět nadpis "Typy plateb"

  Scénář: přidání nového způsobu platby
    Pokud jsem v sekci "administrace typů platby"
    Když kliknu na odkaz "Přidat nový typ platby"
    A vyplním formulář údaji:
      | Název            | Stručný popis                 | Úplný popis                                                   |
      | Dobírka Spořílek | Zboží bude zplacenou dobírkou | Celou částku zaplatíte v hotovosti na naší pobočce v Hlinsku. |
    A zaškrtnu pole "Spořílek.cz" pro vlastnost "Přiřazení k obchodům"
    A kliknu na tlačítko "Vytvořit nový typ platby"
    Pak bych měl vidět zprávu "Typ platby Dobírka Spořílek byl vytvořen"
    A typ platby "Dobírka Spořílek" by měl být vytvořen

  Scénář: smazání existujícího způsobu platby
    Pokud jsem v sekci "administrace typů platby"
    Když kliknu na řádku u typu platby "Na splátky" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Typ platby Na splátky byl smazán"
    A typ platby "Na splátky" by měl být smazán

  Scénář: upravení existujícího způsobu platby
    Pokud jsem v editaci typu platby "Na splátky"
    A změním hodnotu pole "Název" na "Platba kartou"
    Když kliknu na tlačítko "Uložit typ platby"
    Pak bych měl vidět zprávu "Typ platby Platba kartou byl upraven"
    A typ platby "Platba kartou" by měl být upraven

