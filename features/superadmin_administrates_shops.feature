# language: cs
Požadavek: Hlavní správce spravuje obchody

  Abych mohl prezentovat zboží na více webových stránkách
  Jako hlavní správce
  Chci mít možnost vytvářet a upravovat obchody, prostřednictvím kterých je zboží
  prezentováno našim zákazníkům.

  Kontext:
    Pokud jsem přihlášený jako "superadmin"

  Scénář: zobrazení formuláře pro vytvoření nové šablony parametrů
    Když otevřu sekci "administrace šablon parametrů"
    A kliknu na odkaz "Přidat novou šablonu parametrů"
    Pak bych měl vidět nadpis "Nová šablona parametrů"

  Scénář: přidání nového obchodu
    Pokud jsem v sekci "administrace obchodů"
    Když kliknu na odkaz "Přidat nový obchod"
    A vyplním formulář údaji:
      | Název      | Adresa    | Identifikátor |
      | Smart Beko | s-beko.cz | s-beko        |
    A kliknu na tlačítko "Vytvořit nový obchod"
    Pak bych měl vidět zprávu "Obchod Smart Beko byl vytvořen"
    A obchod "Smart Beko" by měl být vytvořen

  Scénář: zobrazení potvrzení smazání existujícího obchodu
    Pokud jsem v sekci "administrace obchodů"
    A obchod "Spořílek.cz" existuje
    Když kliknu na řádku u šablony parametrů "Spořílek" na odkaz "Smazat"
    Pak bych měl vidět nadpis "Opravdu chcete smazat obchod Spořílek.cz?"
    A měl bych vidět "Do následující pole napište SMAZAT, pokud chcete obchod opravdu smazat"

  Scénář: zobrazení potvrzení smazání existujícího obchodu
    Pokud jsem v sekci "administrace obchodů"
    A obchod "Spořílek.cz" existuje
    Když kliknu na řádku u šablony parametrů "Spořílek" na odkaz "Smazat"
    A vyplním "SMAZAT" do pole "Potvrzení smazání"
    A kliknu na tlačítko "Smazat obchod Spořílek.cz"
    Pak bych měl vidět nadpis "Obchod Spořílek.cz byl smazán"
    A obchod "Spořílek.cz" by měl být smazán

  Scénář: upravení existujícího obchodu
    Pokud jsem v sekci "administrace obchodů"
    Když kliknu na řádku u obchodu "Spořílek.cz" na odkaz "Upravit"
    A změním hodnotu pole "Název" na "Spořil"
    A kliknu na tlačítko "Uložit obchod"
    Pak bych měl vidět zprávu "Obchod Spořil byl upraven"
    A obchod "Spořil" by měl být upraven
