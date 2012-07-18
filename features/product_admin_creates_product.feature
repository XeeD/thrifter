# language: cs
Požadavek: Produktový admin vytváří nový produkt

  Abych mohl přidávat do obchodu nové produkty
  Jako produktový admin
  Chci mít možnost jednoduše vytvářet produkty přes administrační rozhraní

  Kontext:
    Pokud jsem přihlášený jako "produktový admin"

  Scénář: otevření formuláře pro přidání nového produktu
    Když otevřu sekci "administrace produktů"
    A kliknu na odkaz "Přidat nový produkt"
    Pak bych měl vidět nadpis "Nový produkt"

  Scénář: přidání nového produktu přes formulář
    Pokud jsem v sekci "administrace produktů"
    Když kliknu na odkaz "Přidat nový produkt"
    A vyplním formulář údaji:
      | Název         | Název odkazu  |
      | LG GB3133TIJW | lg-gb3133tijw |
    A kliknu na tlačítko "Vytvořit výrobek"
    Pak bych měl vidět zprávu "Produkt LG GB3133TIJW byl vytvořen"
    A produkt "LG GB3133TIJW" by měl být vytvořen