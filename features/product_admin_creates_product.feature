# language: cs
Požadavek: Produktový admin vytváří nový produkt

  Abych mohl přidávat do obchodu nové produkty
  Jako produktový admin
  Chci mít možnost jednoduše vytvářet produkty přes administrační rozhraní

  Scénář: otevření formuláře pro přidání nového produktu
    Pokud jsem přihlášený jako produktový admin
    Když otevřu administraci produktů
    A kliknu na odkaz "Přidat nový produkt"
    Pak bych měl vidět formulář pro přidání nového produktu

  Scénář: přidání nového produktu přes formulář
    Pokud jsem přihlášený jako produktový admin
    Když otevřu formulář pro přidání nového produktu
    A vyplním údaje pro produkt "LG GB3133TIJW"
    A kliknu na tlaítko "Přidat výrobek"
    Pak bych měl vidět zprávu "Produkt LG GB3133TIJW byl vytvořen"
    A produkt "LG GB3133TIJW" by měl být vytvořens