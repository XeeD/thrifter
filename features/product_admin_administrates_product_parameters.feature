# language: cs
@wip
Požadavek: Produktový admin upravuje parametry produktu

  Abych mohl zákazníkům přehledně poskytnou podrobné informace o produktu
  Jako produktový admin
  Chci mít možnost přidávat jednotlivé parametry výrobku. Parametry mohou tvořit skupiny
  a mít více hodnot.

  Kontext: 
    Pokud jsem přihlášený jako "produktový admin"
    A upravuji produkt "LG GB3133TIJW"
    A parametr "Šířka" je přiřazen produktu "LG GB3133TIJW"

  Scénář: přidání hodnot parametrů
    A začnu vyplňovat formulář "Parametry"
    A vyplním u skupiny "Rozměry" hodnotu "100" do pole "Šířka"
    A vyberu u skupiny "Parametry" hodnotu "bílá" ze seznamu "Barva"
    A zaškrtnu u skupiny "Funkce a výbava" hodnotu "dětská pojistka" pro vlastnost "Speciální výbava"
    Když kliknu na tlačítko "Uložit produkt"
    Pak by měl parametr "Šířka" mít hodnotu "100"
    Pak by měl parametr "Barva" mít hodnotu "bílá"
    Pak by měl parametr "Speciální výbava" mít jednu z hodnot "Funkce a výbava"

  Scénář: upravení hodnot parametrů
    A začnu vyplňovat formulář "Parametry"
    A vyplním u skupiny "Rozměry" hodnotu "150" v poli "Šířka"
    A vyberu u skupiny "Parametry" hodnotu "černá" ze seznamu "Barva"
    A odškrtnu u skupiny "Funkce a výbava" hodnotu "dětská pojistka" pro vlastnost "Speciální výbava"
    A zaškrtnu u skupiny "Funkce a výbava" hodnotu "držák na lahve" pro vlastnost "Speciální výbava"
    Když kliknu na tlačítko "Uložit produkt"
    Pak parametr "Šířka" by měl mít hodnotu "150"
    Pak parametr "Barva" by měl mít hodnotu "černá"
    Pak parametr "Speciální výbava" by měl mít jednu z hodnot "držák na lahve"
    Ale parametr "Speciální výbava" by neměl mít jednu z hodnot "dětská pojistka"