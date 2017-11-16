# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Vinogradništvo in vinarstvo v Sloveniji

Po tem, ko sem se odločil za vojo tematiko, sem na internetu poiskal podatke, kjer sem si pomagal predvsem s SURS, poleg tega pa še z wikipedio ter spletno stranjo sejma AGRA.
S svojim projektom želim raziskati obširno tematiko vinarstva ter vinogradništva v Sloveniji, predvsem s stališča samega izgleda vinogradov, torej podlage, na kateri rastejo, nagib vinogradov, njihova zatravljenost, ter seveda njihova velikost in razširjenost, po drugi strani pa bom pogeldal pridelavo grozdja v vinogradih in glede na to, pridelavo vina po sortah.
Pri vsem bom upošteval razdeljenost po občinah ter vinorodnih deželah.

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
* `pdftools` - za obdelavo PDF datotek
