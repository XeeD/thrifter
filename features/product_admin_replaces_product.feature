# language: cs
Požadavek: Produktový admin nahrazuje zastaralý produkt novým

  Abych mohl nahradit zastaralý produkt aktuálnějším produktem
  Jako produktorý admin
  Chci mít možnost jednoduše tento zastaralý produkt nahradit za jeho nástupce

  Kontext:
    Pokud jsem přihlášený jako "produktový admin"
    A existují produkty "LG 19LS3500, Philips 32PFL4007H, Samsung UE55ES8000, Grundig 22 VLE 2102 C"

  Scénář: nahrazení zastaralého produktu jedním výrobkem z formuláře
    Pokud upravuji produkt "Samsung UE55ES8000" a jsem na záložce "Nahrazení"
    Když vyberu hodnotu "LG 19LS3500" ze seznamu "Nahradit výrobkem"
    A kliknu na tlačítko "Nahradit"
    Pak produkt "LG 19LS3500" by měl být náhradou současného produktu
    A stav produktu by měl být "Nahrazený"

  Scénář: nahrazení zastaralého výrobku dvěma výrobky najednou z formuláře
    Pokud upravuji produkt "Samsung UE55ES8000" a jsem na záložce "Nahrazení"
    Když vyberu hodnoty "LG 19LS3500, Grundig 22 VLE 2102 C" ze seznamu "Nahradit výrobkem"
    A kliknu na tlačítko "Nahradit"
    Pak produkt "LG 19LS3500" by měl být náhradou současného produktu
    A produkt "Grundig 22 VLE 2102 C" by měl být náhradou současného produktu

  Scénář: odstranění jedné náhrady
    Pokud upravuji produkt "Philips 32PFL4007H" a jsem na záložce "Nahrazení"
    A produkt "Samsung UE55ES8000" je náhradou současného produktu
    A produkt "LG 19LS3500" je náhradou současného produktu
    Když kliknu na řádku u nahrazujícího produktu "Samsung UE55ES8000" na odkaz "Smazat"
    Pak produkt "Samsung UE55ES8000" by neměl být náhradou současného produktu
    A stav produktu by měl být "Nahrazený"

  Scénář: odstranění všech náhrad odkazem "Smazat všechny"
    Pokud upravuji produkt "Philips 32PFL4007H" a jsem na záložce "Nahrazení"
    A produkt "Samsung UE55ES8000" je náhradou současného produktu
    A produkt "LG 19LS3500" je náhradou současného produktu
    Když kliknu na odkaz "Smazat všechny"
    Pak produkt "Samsung UE55ES8000" by neměl být náhradou současného produktu
    A produkt "LG 19LS3500" by neměl být náhradou současného produktu
    A stav produktu by měl být "Viditelný"
