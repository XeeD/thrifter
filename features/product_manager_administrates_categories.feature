# language: cs
Požadavek: Produktový manager spravuje kategorie

  Abych mohl spravovat kategorie
  Jako produktový manager
  Chci mít možnost jednoduchého přidávání, přesouvání, upravování a mazání kategorií

  Kontext:
    Pokud jsem přihlášený jako "produktový manager"
    A kategorie "Pračky" existuje

  Scénář: vytvoření nové kategorie
    Když otevřu sekci "administrace kategorií"
    A kliknu na odkaz "Přidat novou kategorii"
    Pak bych měl vidět nadpis "Nová kategorie"

  Scénář: přidání nové kategorie přes formulář
    Pokud jsem v sekci "administrace kategorií"
    Když kliknu na odkaz "Přidat novou kategorii"
    A vyplním formulář údaji:
      | Název          | Název v odkazu       | Celý název (mn. č.)  | Celý název (j. č.)   |
      | Předem plněné  | predem-plnene-pracky | Předem plněné pračky | Předem plněná pračka |
    A vyberu hodnotu "Navigační" ze seznamu "Typ kategorie"
    A zaškrtnu přepínač "Bílé zboží" pro vlastnost "Nadřazená kategorie"
    A kliknu na tlačítko "Vytvořit novou kategorii"
    Pak bych měl vidět zprávu "Kategorie Předem plněné pračky byla vytvořena"
    A kategorie "Předem plněné pračky" by měla být vytvořena

  Scénář: smazání existující kategorie
    Pokud jsem v sekci "administrace kategorií"
    Když kliknu na řádku u kategorie "Pračky" na odkaz "Editovat"
    Pak bych měl vidět zprávu "Kategorie Pračky byla smazána"
    A kategorie "Pračky" by měla být smazána

  Scénář: upravení existující kategorie
    Pokud jsem v sekci "administrace kategorií"
    A kliknu na řádku u kategorie "Pračky" na odkaz "Editovat"
    A změním hodnotu pole "Název" na "Automatické pračky"
    A kliknu na tlačítko "Uložit kategorii"
    Pak bych měl vidět zprávu "Kategorie Automatické pračky byla upravena"
    A kategorie "Automatické pračky" by měla být upravena