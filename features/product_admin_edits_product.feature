# language: cs
Požadavek: Produktový admin edituje produkt

  Abych mohl změnit údaje již existujícího produktu
  Jako produktorý admin
  Chci mít možnost jednoduše editovat produkt v administračním rozhraní

  Kontext:
    Pokud jsem přihlášený jako "produktový admin"

  Scénář: zobrazení konkrétního produktu v seznamu produktů
    A existuje "produkt" "LG GB3133TIJW"
    Když otevřu sekci "Produkty -> Správa produktů"
    Pak bych měl vidět seznam "produktů"
    A měl bych vidět "LG GB3133TIJW"

  Scénář: zobrazení editace konkrétního produktu
    Pokud produkt "LG GB3133TIJW" existuje
    Když kliknu na odkaz "Editovat"
    Pak bych měl vidět nadpis "Editace produktu LG GB3133TIJW"

  Scénář: změna jména produktu
    Pokud jsem v editaci produktu "LG GB3133TIJW"
    Když změním hodnotu pole "název produktu" na "LG GB 3133 TIJW"
    A kliknu na tlačítko "Uložit"
    Pak bych měl vidět zprávu "Produkt LG GB 3133 TIJW byl upraven"
    A měl bych vidět produkt se jménem "LG GB 3133 TIJW"