# language: cs
Požadavek: Manager obchodu spravuje články kategorií

  Abych mohl prezentovat články pro jednotlivé obchody a jejich kategorie
  Jako správce obchodů
  Chci mít možnost přidávat a upravovat články pro kategorie v jednotlivých obchodech

  Kontext:
    Pokud jsem přihlášený jako "manager obchodu"
    A článek "LCD TV" v obchodu "Spořílek.cz" existuje

  Scénář: vypsání všech článků z jednoho obchodu
    Když otevřu sekci "administrace článků"
    A kliknu na odkaz "Spořílek.cz"
    Pak bych měl vidět "Články v obchodu Spořílek.cz"
    A měl bych vidět "LCD TV"

  @wip
  Scénář: vytvoření nového články
    Pokud mám otevřenou administraci článků pro obchod "Spořílek.cz"
    Když kliknu na odkaz "Přidat nový článek"
    A vyplním formulář údaji:
    | Název          | Titulek            | Název v odkazu |
    | Vodní vysavače | Vodní vysavače AEG | vodni-vysavace |
    A pokračuji ve vyplňování formuláře:
    | Shrnutí                     | Text |
    | Vysáváme s vodním vysavačem | Vodní vysavače jsou nejlepší |
    # A vyberu kategorii ...
    A kliknu na tlačítko "Vytvořit článek"
    Pak bych měl vidět zprávu "Článek Vodní vysavače byl vytvořen"
    # A měl bych vidět "Vodní vysavače" v obchodě..
    A článek "Vodní vysavače" by měl být vytvořen

  Scénář: Smazání existujícího článku
    Pokud mám otevřenou administraci článků pro obchod "Spořílek.cz"
    Když kliknu na řádku u článku "LCD TV" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Článek LCD TV byl smazán"
    A článek "LCD TV" by měl být smazán

  Scénář: upravení existujícího článku
    Pokud mám otevřenou administraci článků pro obchod "Spořílek.cz"
    A kliknu na řádku u článku "LCD TV" na odkaz "Upravit"
    A změním hodnotu pole "Název" na "PLAZMA TV"
    Když kliknu na tlačítko "Uložit článek"
    Pak bych měl vidět zprávu "Článek PLAZMA TV byl upraven"
    A článek "PLAZMA TV" by měl být upraven