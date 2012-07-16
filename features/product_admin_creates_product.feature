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
    Pak bych měl vidět formulář "přidání nového produktu"

  Scénář: přidání nového produktu přes formulář
    Když otevřu formulář "přidání nového produktu"
    A vyplním údaj "název" hodnotou "LG GB3133TIJW"
    A kliknu na tlačítko "Přidat výrobek"
    Pak bych měl vidět zprávu "Produkt LG GB3133TIJW byl vytvořen"
    A produkt "LG GB3133TIJW" by měl být vytvořen