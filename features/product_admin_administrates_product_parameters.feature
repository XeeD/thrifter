# language: cs
Požadavek: Produktový admin upravuje parametry produktu

  Abych mohl zákazníkům přehledně poskytnou podrobné informace o produktu
  Jako produktový admin
  Chci mít možnost přidávat jednotlivé parametry výrobku. Parametry mohou tvořit skupiny
  a mít více hodnot.

  Kontext:
    Pokud jsem přihlášený jako "produktový admin"
    A upravuji produkt "LG GB3133TIJW"

  Náčrt Scénáře: vyplnění hodnoty parametru
    Pokud parametr "<param_type>" je přiřazen produktu
    Když vyplním "<value>" do pole "<param_type>"
    A kliknu na tlačítko "Uložit produkt"
    Pak hodnota parametru "<param_type>" by měla být "<value>"

    Příklady:
    | param_type | value |
    | Šířka      | 100   |
    | Výška      | 150   |
    | Hloubka    | 80    |

  Náčrt Scénáře: změna hodnoty parametru
    Pokud parametr "<param_type>" je přiřazen produktu a má hodnotu "<old_value>"
    Když změním hodnotu pole "<param_type>" na "<value>"
    A kliknu na tlačítko "Uložit produkt"
    Pak hodnota parametru "<param_type>" by měla být "<value>"

    Příklady:
    | param_type | old_value | value |
    | Šířka      | 100       | 120   |
    | Výška      | 150       | 170   |
    | Hloubka    | 80        | 100   |

  Scénář: vybrání jedné hodnoty z nabídky několika hodnot parametru
    Pokud parametr "Barva" je přiřazen produktu
    Když vyberu hodnotu "bílá" ze seznamu "Barva"
    A kliknu na tlačítko "Uložit produkt"
    Pak hodnota parametru "Barva" by měla být "bílá"

  Scénář: změna jedné hodnoty z nabídky několika hodnot parametru
    Pokud parametr "Barva" je přiřazen produktu a má hodnotu "bílá"
    Když vyberu hodnotu "černá" ze seznamu "Barva"
    A kliknu na tlačítko "Uložit produkt"
    Pak hodnota parametru "Barva" by měla být "černá"

  Scénář: zaškrtnutí hodnoty z nabídky několika hodnot parametru
    Pokud parametr "Speciální funkce" je přiřazen produktu
    Když zaškrtnu pole "Dětská pojistka" pro vlastnost "Speciální funkce"
    A kliknu na tlačítko "Uložit produkt"
    Pak jedna z hodnot parametru "Speciální funkce" by měla být "Dětská pojistka"
    Ale jedna z hodnot parametru "Speciální funkce" by neměla být "BioShield"

  Scénář: vybrání pravdivostní hodnoty z nabídky
    Pokud parametr "Výrobník ledu" je přiřazen produktu
    Když vyberu hodnotu "Ano" ze seznamu "Výrobník ledu"
    A kliknu na tlačítko "Uložit produkt"
    Pak hodnota parametru "Výrobník ledu" by měla být "Ano"

  Scénář: změna pravdivostní hodnoty v nabídce
    #Pokud parametr "Výrobník ledu" je přiřazen produktu a má hodnotu ""
    #Když vyberu hodnotu "Ne" ze seznamu "Výrobník ledu"

  Scénář: přidání nové hodnoty do seznamu
    Pokud parametr "Speciální funkce" je přiřazen produktu
    Když přidám novou hodnotu "Fuzzy Logic" do seznamu "Speciální funkce"
    A kliknu na tlačítko "Uložit produkt"
    Pak jedna z hodnot parametru "Speciální funkce" by měla být "Fuzzy Logic"

  Scénář: přidání více nových hodnot najednou do seznamu

