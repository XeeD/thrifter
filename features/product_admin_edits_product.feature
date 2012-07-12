# language: cs
Požadavek: Produktový admin edituje produkt

  Abych mohl změnit údaje již existujícího produktu
  Jako produktorý admin
  Chci mít možnost jednoduše editovat produkt v administračním rozhraní

  Scénář: zobrazení konkrétního produktu v seznamu produktů
    Pokud jsem přihlášený jako produktový admin
    A existuje produkt "LG GB3133TIJW"
    Když otevřu administraci produktů
    Pak bych měl vidět seznam produktů
    A měl bych vidět produkt se jménem "LG GB3133TIJW"

  Scénář: zobrazení editace konkrétního produktu
    Pokud jsem přihlášený jako produktový admin
    A jsem v administraci produktů
    A existuje produkt "LG GB3133TIJW"
    Když kliknu na "Editovat" u produktu "LG GB3133TIJW"
    Pak bych měl vidět formulář pro editaci produktu
    A název produktu by měl být "LG GB3133TIJW"

  Scénář: změna jména produktu
    Pokud jsem přihlášený jako produktový admin
    A jsem v editaci produktu "LG GB3133TIJW"
    Když změním hodnotu pole "název produktu" na "LG GB 3133 TIJW"
    A kliknu na tlačítko "Uložit"
    Pak bych měl vidět zprávu "Produkt LG GB 3133 TIJW byl upraven"
    A měl bych vidět produkt se jménem "LG GB 3133 TIJW"