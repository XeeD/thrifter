# language: cs
@wip
Požadavek: Produktový admin může přiřazovat produkt libovolnému množství kategorií

  Abych zjednodušil orientaci zákazníků ve velkém množství produktů na našich stránkách
  Jako produktový admin
  Chci mít možnost přiřazovat produkt do více kategorií.

  Kategorie produktu může být označena jako hlavní. Každý produkt může být zařazen
  jen v jedné hlavní kategorii v daném obchodě. Tzn. produkt má v každém obchodě pouze jednu
  hlavní kategorii. Pokud je zařazen ve 2 obchodech, tak má právě 2 hlavní kategorie.

  Hlavní kategorie je použita vždy, když
  odkazujeme na produkt "bez kontextu". Například:
    - pokud odkazujeme na produkt z hlavní stránky
    - pokud generujeme odkaz pro porovnávač cen

  Dodatečné kategorie se používají pouze pro alternativní zařazeí produktu.
  Pokud mám například 3D LED televizi, tak jako hlavní kategorii pro ni určím Televize -> LED televize.
  Mohu ji ale přidat i do dodatečných kategorií:
    - Televize -> 3D LED televize
    - 3D technologie -> LED televize

  Odkaz na produkt v této dodatečné kategorii se generuje pouze pokud na tento produkt odkazuje
  přímo v kontextu této kategorie.
  Příklad: jsme v kategorii 3D technologie -> LED televize
           televizor má sice hlavní kategorii Televize -> LED televize, ale odkážeme na něj jako
             /3d-technologie-led-televize/produkt-abcd
           abychom i po přesunutí na detail produktu zachovali "kontext" kategorie, ve které
           jej zákazník původně nalezl

  Kontext:
    Pokud jsem v editace produktu "Samsung UE55ES8000" na záložce "Kategorie"

  Scénář: Přidání produktu do dodatečné kategorie
    Pokud je produkt zařazen v hlavní kategorii "Televize -> LED televize" v obchodu "Spořílek.cz"
    Když kliknu na odkaz "Přidat do další kategorie" u obchodu "Spořílek.cz"
    A vyberu kategorii "3D Technologie -> Televize"
    A kliknu na tlačítko "Přidat do kategorie"
    Pak by měl produkt být zařazen v alternativní kategorii "3D technologie -> Televize" v obchodu "Spořílek.cz"
    A měl by být zařazen v hlavní kategorii "Televize -> LED televize" v obchodu "Spořílek.cz"

  Scénář: Změna hlavní kategorie produktu
    Pokud je produkt zařazen v hlavní kategorii "Televize -> LED televize" v obchodu "Spořílek.cz"
    Když kliknu na odkaz "Změnit hlavní kategorii" u obchodu "Spořílek.cz"
    A vyberu kategorii "3D Technologie -> Televize"
    A kliknu na tlačítko "Změnit hlavní kategorii"
    Pak by měl produkt být zařazen v hlavní kategorii "3D technologie -> Televize" v obchodu "Spořílek.cz"

  Scénář: Přidání produktu do dalšího obchodu
    Pokud produkt není zařazen v obchodě "Smart Samsung"
    Když vyberu hodnotu "Smart Samsung" ze seznamu "Obchody"
    A kliknu na tlačítko "Přidat do obchodu"
    A vyberu kategorii "Televizory -> LED LCD"
    A kliknu na tlačítko "Přidat do obchodu"
    Pak by měl produkt být zařazen v hlavní kategorii "Televizory -> LED LCD" v obchodu "Smart Samsung"

  Scénář: Vyřazení výrobku z obchodu
    Pokud je produkt zařazen v hlavní kategorii "Televizory -> LED LCD" v obchodu "Smart Samsung"
    A není zařazen v žádných dalších kategoriích
    Když kliknu na odkaz "Odebrat z tohoto obchodu" u obchodu "Smart Samsung"
    Pak bych měl vidět zprávu "Produkt Samsung UE55ES8000 byl odebrán z obchodu Smart Samsung"
    A produkt by neměl být zařazen v obchodu Smart Samsung v žádné kategorii

  Scénář: Odebrání obchodu z alternativní kategorie
    Pokud je produkt zařazen v alternativní kategorii "Televize -> 3D televize" v obchodu "Spořílek.cz"
    Když kliknu na odkaz "odebrat alternativní kategorii" této kategorie
    Pak bych měl vidět zprávu "Produkt byl vyřazen z alternativní kategorie"
    A produkt by neměl být zařazen v kategorii "Televize -> 3D televize" v obchodu "Spořílek.cz"