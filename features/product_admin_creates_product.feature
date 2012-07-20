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

  Scénář: přidání nového produktu
    Pokud jsem v sekci "administrace produktů"
    A značka "Indesit" existuje
    Když kliknu na odkaz "Přidat nový produkt"
    A vyplním formulář údaji:
      | Celý název    | Model         | Název v odkazu | Číslo v Cézaru | Stručný popis     |
      | LG GB3133TIJW | LG GB3133TIJW | lg-gb3133tijw  | 2124567        | Perfektní lednice |
    A pokračuji ve vyplňování formuláře:
      | Popis            | Výchozí cena | Doporučená cena | Nákupní cena | PHE | Záruka | % DPH |
      | No-Frost lednice | 12990        | 15990           | 9000         | 217 | 24     | 20    |
    A vyberu hodnotu "Indesit" ze seznamu "Značka"
    A kliknu na tlačítko "Vytvořit nový produkt"
    Pak bych měl vidět zprávu "Nový produkt LG GB3133TIJW byl vytvořen"
    A produkt "LG GB3133TIJW" by měl být vytvořen