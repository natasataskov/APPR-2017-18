# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Vinogradništvo v Sloveniji

Po tem, ko sem se odločil za vojo tematiko, sem na internetu poiskal podatke, kjer sem si pomagal predvsem s [SURS](http://www.stat.si/statweb), poleg tega pa še z [wikipedio](https://en.wikipedia.org/wiki/List_of_grape_varieties).
S svojim projektom želim raziskati obširno tematiko vinogradništva v Sloveniji, predvsem s stališča samega izgleda vinogradov, torej podlage, na kateri rastejo, nagib vinogradov, njihova zatravljenost, ter seveda njihova velikost in razširjenost, po drugi strani pa bom pogledal pridelavo grozdja v vinogradih po sortah, ter pogledal avtohtone slovenske sorte.
Pri vsem bom upošteval razdeljenost po občinah ter vinorodnih deželah.
Podatki, ki sem jih našel na SURS, se nanašajo na zelo različna leta in so zato problematični, saj se jih ne da lepo zdrušiti in/ ali primerjati. Velik problem je tudi nedostopnost podatkov, saj vsi podatki niso splošno dostopni, saj so poslovna tajnost, kar je bil tudi eden izmed razlogov, da nisem obravnaval tudi vinarstva. 

Prvi del je prvi del mojega raziskovanja, torej vinogradi po zunanjem izgledu, kjer bom opazoval zunanje značilnosti, kot so na primer zatravljenost, nagib površine, število trt itd. V tabeli bom imel stolpce Vinorodna dežela, Zunanje lastnosti ter meritve. 
Tudi v drugem delu raziskovanja bom imel tri stolpce, vendar bodo opisi oznak drugačni. Ponovno bom imel Vinorodno deželo, ter Meritev, osrednji stolpec pa bo Opis trt, kjer bom opisal starost ter sorte.
Naloga pa bo vsebovala tudi dve primerjalni tabeli, in sicer tabelo sloevsnkih avtohtonih sort ter tabelo ekološke pridelave.

Prvi del je prvi del mojega raziskovanja, torej vinogradi po zunanjem izgledu. Moja tabela bo imela  vač stolpcev 
`Vinorodna dežela` - vinogradništvo bom razdelil na 4 regije, Primorsko, Podravsko, Posavsko ter zunaj vinorodnih območij,
  - `zatravljenost` - meritev: površina, razdeljeno na zatravljeno in nezatravljeno(število),
  - `nagib` - meritev: površina, razdeljeno na različne stopnje nagibov površja(število),
  - `pridelovalci` - meritev: število pridelovalcev(število),
  - `število vinogradov` - meritev: število vinogradov (število),
  - `podlaga` - meritev: število trt, ki rastejo na določeni podlagi(število),
 
  
2. Tudi v drugem delu raziskovanja bom imel tri stolpce, vendar bodo opisi oznak drugačni.
`Vinorodna dežela` - vinogradništvo bom razdelil na 4 regije, Primorsko, Podravsko, Posavsko ter zunaj vinorodnih območij,
  - `sorta` - meritev: število trt določene sorte(število),
  - `starost` - meritev: število trt določene starosti (število),

3. Za mojo nalogo bodo pomembne tudi dve primerjalne tabele, in sicer:
  - Tabelo slovenskih avtohtonih sort
  - Tabela ekološke pridelave 
  


## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

