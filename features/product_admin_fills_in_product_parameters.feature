# language: cs
@wip
Požadavek: Produktový admin upravuje parametry produktu

  Abych mohl zákazníkům přehledně poskytnou podrobné informace o produktu
  Jako produktový admin
  Chci mít možnost přidávat jednotlivé parametry výrobku. Parametry mohou tvořit skupiny
  a mít více hodnot.

  Kontext:
    Pokud jsem přihlášený jako "produktový admin"
    A upravuji produkt "LG GB3133TIJW" a jsem na záložce "Parametry"

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

  Scénář: vybrání jedné hodnoty z nabídky několika hodnot parametru
    Pokud parametr "Barva" je přiřazen produktu
    Když zaškrtnu přepínač "bílá" na řádku pro vlastnost "Barva"
    A kliknu na tlačítko "Uložit produkt"
    Pak hodnota parametru "Barva" by měla být "bílá"

  Scénář: změna jedné hodnoty z nabídky několika hodnot parametru
    Pokud parametr "Barva" je přiřazen produktu a má hodnotu "bílá"
    Když zaškrtnu přepínač "černá" na řádku pro vlastnost "Barva"
    A kliknu na tlačítko "Uložit produkt"
    Pak hodnota parametru "Barva" by měla být "černá"

  Scénář: zaškrtnutí hodnoty z nabídky několika hodnot parametru
    Pokud parametr "Speciální funkce" je přiřazen produktu
    Když zaškrtnu pole "BigBox" na řádku pro vlastnost "Speciální funkce"
    A kliknu na tlačítko "Uložit produkt"
    Pak jedna z hodnot parametru "Speciální funkce" by měla být "BigBox"
    Ale jedna z hodnot parametru "Speciální funkce" by neměla být "BioShield"

  Scénář: vybrání pravdivostní hodnoty z nabídky
    Pokud parametr "Výrobník ledu" je přiřazen produktu
    Když zaškrtnu přepínač "Ano" na řádku pro vlastnost "Výrobník ledu"
    A kliknu na tlačítko "Uložit produkt"
    Pak hodnota parametru "Výrobník ledu" by měla být "Ano"

  Scénář: přidání nové hodnoty do seznamu
    Pokud parametr "Speciální funkce" je přiřazen produktu
    Když přidám novou hodnotu "Fuzzy Logic" do seznamu "Speciální funkce"
    A kliknu na tlačítko "Uložit produkt"
    Pak jedna z hodnot parametru "Speciální funkce" by měla být "Fuzzy Logic"

  Scénář: přidání více nových hodnot najednou do seznamu

