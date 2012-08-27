# language: cs
Požadavek: Manager obchodu spravuje dokumenty

  Abych mohl v e-shopu zobrazit různé textové dokumenty
  Jako manager obchodu
  Chci mít možnost jejich snadné administrace.
  Systém mi musí v administraci umožnit jednotlivé dokumenty vytvářet, upravovat a mazat.

  Kontext:
    Pokud jsem přihlášený jako "manager obchodu"
    A obchod "Spořílek.cz" existuje
    A obchod "Smart Elektro" existuje

  Scénář: vytvoření nového dokumentu
    Když otevřu sekci "administrace dokumentů"
    A kliknu na odkaz "Přidat nový dokument"
    Pak bych měl vidět nadpis "Nový dokument"

  Scénář: přidání nového dokumentu přes formulář
    Pokud jsem v sekci "administrace dokumentů"
    Když kliknu na odkaz "Přidat nový dokument"
    A vyplním formulář údaji:
      | Název   | Titulek       | Název v odkazu      | Text               |
      | Doprava | Doprava zboží | doprava             | Doprava není zdarma |
    A zaškrtnu pole "Spořílek.cz" pro vlastnost "Přiřazen k obchodům"
    A kliknu na tlačítko "Vytvořit nový dokument"
    Pak bych měl vidět zprávu "Dokument Doprava byl vytvořen"
    A dokument "Doprava" by měl být vytvořen
    A dokument "Doprava" by měl být přiřazen obchodu "Spořílek.cz"
    Ale dokument "Doprava" by neměl být přiřazen obchodu "Smart Elektro"

  Scénář: smazání existujícího dokumentu
    Pokud dokument "Platba" existuje
    A jsem v sekci "administrace dokumentů"
    Když kliknu na řádku u dokumentu "Platba" na odkaz "Smazat"
    Pak bych měl vidět zprávu "Dokument Platba byl smazán"
    A dokument "Platba" by měl být smazán

  Scénář: upravení existujícího dokumentu
    Pokud jsem v editaci dokumentu "Platba"
    Pak bych měl vidět nadpis "Úprava dokumentu Platba"

  Scénář: upravení existujícího dokumentu přes formulář
    Pokud jsem v editaci dokumentu "Platba"
    A změním hodnotu pole "Název" na "Platba kartou"
    A odškrtnu pole "Spořílek.cz" pro vlastnost "Přiřazen k obchodům"
    A zaškrtnu pole "Smart Elektro" pro vlastnost "Přiřazen k obchodům"
    A kliknu na tlačítko "Uložit dokument"
    Pak bych měl vidět zprávu "Dokument Platba kartou byl upraven"
    A dokument "Platba kartou" by měl být upraven
    A dokument "Platba kartou" by měl být přiřazen obchodu "Smart Elektro"
    Ale dokument "Platba kartou" by neměl být přiřazen obchodu "Spořílek.cz"