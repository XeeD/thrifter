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
    A parametr "Šířka" je přiřazen produktu
    A parametr "Barva" je přiřazen produktu
    A parametr "Speciální funkce" je přiřazen produktu
    A začnu vyplňovat parametry produktu

  Scénář: vyplnění hodnoty parametru
    Když vyplním "100" do pole "Šířka"
    A kliknu na tlačítko "Uložit produkt"
    Pak by měl mít parametr "Šířka" u produktu hodnotu "100"

  Scénář: vybrání jedné hodnoty z nabídky parametru
    Když vyberu hodnotu "bílá" ze seznamu "Barva"
    A kliknu na tlačítko "Uložit produkt"
    Pak by měl mít parametr "Barva" u produktu hodnotu "bílá"

  Scénář: zaškrtnutí několika hodnot z nabídky parametru
    Když zaškrtnu pole "Dětská pojistka" pro vlastnost "Speciální funkce"
    A kliknu na tlačítko "Uložit produkt"
    Pak by měl mít parametr "Speciální funkce" u produktu hodnotu "Dětská pojistka"

  #Scénář: upravení hodnot parametrů
  #  Když vyplním u skupiny "Rozměry" hodnotu "150" v poli "Šířka"
  #  A vyberu u skupiny "Parametry" hodnotu "černá" ze seznamu "Barva"
  #  A odškrtnu u skupiny "Funkce a výbava" hodnotu "dětská pojistka" pro vlastnost "Speciální výbava"
  #  A zaškrtnu u skupiny "Funkce a výbava" hodnotu "držák na lahve" pro vlastnost "Speciální výbava"
  #  A kliknu na tlačítko "Uložit produkt"
  #  Pak parametr "Šířka" by měl mít hodnotu "150"
  #  Pak parametr "Barva" by měl mít hodnotu "černá"
  #  Pak parametr "Speciální výbava" by měl mít jednu z hodnot "držák na lahve"
  #  Ale parametr "Speciální výbava" by neměl mít jednu z hodnot "dětská pojistka"