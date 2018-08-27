# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Vpliv ureditve zdravstvenega sistema na pričakovano življenjsko dobo

V projektu bom analizirala vpliv zdravstvene ureditve v povezavi s pričakovano življenjsko dobo v posameznih državah. Analizirala bom, kako dejavne so posamezne države na posameznih področjih v zdravstvu, kateri so glavni ponudniki zdravstvenih storitev in kakšna je shema financiranja zdravstva v posameznih državah. Cilj projekta je poiskati, kakšna ureditev zdravstvenega sistema je najbolj optimalna za državo.

Tabela 1: PRIČAKOVANA ŽIVLJENJSKA DOBA

 * stolpec 1: Leto (število)
 * stolpec 2: Država (faktor)
 * stolpec 3: Spol (faktor)
 * stolpec 4: Starost (število)
 * stolpec 5: Pričakovana življenjska doba (realno število)

Tabela 2: IZDATKI ZA POSAMEZNE FUNKCIJE ZDRAVSTVENE NEGE

 * stolpec 1: Leto (število)
 * stolpec 2: Država (faktor)
 * stolpec 3: Funkcija (faktor)
 * stolpec 4: Izdatki za posamezno funkcijo (realno število)

Tabela 3: IZDATKI PONUDNIKOV ZDRAVSTVENIH STORITEV

 * stolpec 1: Leto (število)
 * stolpec 2: Država (faktor)
 * stolpec 3: Ponudnik (faktor)
 * stolpec 4: Izdatki posameznih ponudnikov (realno število)

Tabela 4: SHEME FINANCIRANJA ZDRAVSTVENIH STORITEV

 * stolpec 1: Leto (število)
 * stolpec 2: Država (faktor)
 * stolpec 3: Shema financiranja (faktor)
 * stolpec 4: Izdatki (realno število)

Viri:

 * http://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=demo_mlexpec&lang=en

 * http://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=hlth_sha11_hc&lang=en

 * http://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=hlth_sha11_hp&lang=en

 * http://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=hlth_sha11_hf&lang=en


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
