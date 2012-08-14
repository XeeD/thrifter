# language: cs
Požadavek: Produktový admin edituje produkt

  Abych mohl změnit údaje již existujícího produktu
  Jako produktorý admin
  Chci mít možnost jednoduše editovat produkt v administračním rozhraní

  Kontext:
    Pokud jsem přihlášený jako "produktový admin"
    A existuje produkt "LG GB3133TIJW"

  Scénář: zobrazení konkrétního produktu v seznamu produktů
    Když otevřu sekci "administrace produktů"
    Pak bych měl vidět podnadpis "Seznam produktů"
    A měl bych vidět "LG GB3133TIJW"

  Scénář: zobrazení editace konkrétního produktu
    Když otevřu sekci "administrace produktů"
    A kliknu na řádku u produktu "LG GB3133TIJW" na odkaz "Upravit"
    Pak bych měl vidět nadpis "Editace produktu LG GB3133TIJW"

  Scénář: změna jména produktu
    Když otevřu sekci "administrace produktů"
    A kliknu na řádku u produktu "LG GB3133TIJW" na odkaz "Upravit"
    A změním hodnotu pole "Celý název" na "LG GB 3133 TIJW"
    A kliknu na tlačítko "Uložit produkt"
    Pak bych měl vidět zprávu "Produkt LG GB 3133 TIJW byl upraven"
    A měl bych vidět "LG GB 3133 TIJW"