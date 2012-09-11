# language: cs
Požadavek: Zákazník vkládá, upravuje množství a maže produkty v košíku

  Abych mohl objednat žádaný produkt v mnou požadovaném množství
  Jako zákazník
  Chci mít možnost vložit zboží do nákupního košíku, upravit jeho množství,
  případně smazat a následně ho objednat

  Scénář: přidání produktu do košíku
    Pokud jsem v detailu produktu "LG GB3133TIJW"
    Když kliknu na tlačítko "Vložit do košíku"
    Pak bych měl být přesměrován na stránku

  Scénář: upravení množství zboží v košíku
    Pokud mám v košíku vloženo zboží "LG GB3133TIJW"
    Když změním hodnotu množství na řádku u produktu "LG GB3133TIJW"
    A kliknu na tlačítko "Přepočítat"
    Pak by mělo být množství produktu změněno

  Scénář: smazání zboží v košíku odkazem
  Scénář: smazání zboží v košíku změnou množství na nulu
