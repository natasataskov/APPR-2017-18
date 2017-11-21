# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

# Funkcija, ki uvozi podatke o vinskih sortah iz Wikipedije
#uvozi.obcine <- function() {
#  link <- ""
# stran <- html_session(link) %>% read_html()
#  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
#    .[[1]] %>% html_table(dec = ",")
# for (i in 1:ncol(tabela)) {
#    if (is.character(tabela[[i]])) {
#      Encoding(tabela[[i]]) <- "UTF-8"
#    }
#  }
#  colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
#                        "ustanovitev", "pokrajina", "regija", "odcepitev")
#  tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
#  tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
#  tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
#  for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
#     tabela[[col]] <- parse_number(tabela[[col]], na = "-", locale = sl)
#   }
#   for (col in c("obcina", "pokrajina", "regija")) {
#     tabela[[col]] <- factor(tabela[[col]])
#   }
#   return(tabela)
# }
# 
# # Funkcija, ki uvozi podatke iz datoteke druzine.csv
# uvozi.druzine <- function(obcine) {
#   data <- read_csv2("podatki/druzine.csv", col_names = c("obcina", 1:4),
#                     locale = locale(encoding = "Windows-1250"))
#   data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
#     strapplyc("([^ ]+)") %>% sapply(paste, collapse = " ") %>% unlist()
#   data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
#   data <- data %>% melt(id.vars = "obcina", variable.name = "velikost.druzine",
#                         value.name = "stevilo.druzin")
#   data$velikost.druzine <- parse_number(data$velikost.druzine)
#   data$obcina <- factor(data$obcina, levels = obcine)
#   return(data)
# }
# 
# # Zapišimo podatke v razpredelnico obcine
# obcine <- uvozi.obcine()
# 
# # Zapišimo podatke v razpredelnico druzine.
# druzine <- uvozi.druzine(levels(obcine$obcina))
# Da bomo delali v mapi, v kateri imamo vse podatke

setwd("C:/Users/Lenovo_Uporabnik/Desktop/FMF/2. letnik/R/Projekt/APPR-2017-18/podatki")
require(dplyr)
require(readr)
#Podatke bom uvajal po vrsti; najprej tiste, ki so potrebni za prvi del naloge, nato za drugi itd.

#Prvi del

#velikosti vinogradov od 2000 do 2016
velikost_slovenskih_vinogradov = read.csv2("velikost_vinogradov.csv")
#velikosti vinogradov in število trt 2000 in 2010
velikost.stevilo_trt =read.csv2("velikost_vinogradov_število_trt.csv")
#pridelovalci po statističnih regijah
pridelovalci_regije = read.csv2(
  "Pridelovalci, površina, Število vinogradov in število sadik glede na sedež kmetijskega gospodarstva,statistične regije, Slovenija, 2009 in 2015")
#pridelovalci po površini
pridelovalci_povrsina =read.csv2("razredi_pridelovalcev_2009_2015.csv")
#površina in število vinogradov glede na nagib vertikal po vinorodnih deželah in okoliših
vertikale = read.csv2("Povšina_nagib_vertikal.csv")
#površina, število vinogradov in sadik glede na zatravljenost
zatravljenost = read.csv2("Površina_zatravljenost.csv")
#površina, število vinogradov in sadik 2009, 2015
povrsina.stevilo_vinogradov.sadik = read.csv2("
  Površina, število vinogradov in število sadik po VINORODNA DEŽELA IN OKOLIŠ, VELIKOSTNI RAZREDI, LETO , MERITVE.csv")
#podlaga na kateri rastejo trte 2009 in 2015
podlaga = read.csv2("Površina_podlaga_2009_2015")
#način gojenja trt
gojenje = read.csv2("Površina_gojitvena_oblika_2009_2015")
#ekološka pridelava (primerjava)
ekolosko = read.csv2("Ekološka_pridelava.csv")
#površina in število trsnic, matičnjakov in vinogradov (primerjava)
trsnice.maticnjaki = read.csv2("trsnice_matičnjaki_vinogradi_regije_2009.csv")

#Drugi del

#Najpogostejše sorte po površini, številu sadik
sorte.povrsina_sadike = read.csv2("
                                 Povšina vinogradov in število sadik najpogostejših sort, vinorodne dežele, Slovenija, 2009 in 2015.csv")
#Starost trt po površini in številu sadik
starost.povrsin_sadike = read.csv2("Površina vinogradov in število sadik po starostnih razredih, vinorodne dežele in okoliši, Slovenija, 2009 in 2015")
#Najpogostejše sorte po starosti
sorte_starost = read.csv2("Površina_najpogostejše_sorte_starost_2009_2015.csv")
#Pridelava grozdja
grozdje = read.csv2("pridelava_grozdja2000-2016.csv")
#Pridelava po količini 2009
kolicina = read.csv2("pridelovalci_količina.csv")
#vpeljava naših domačih sort
#branje iz spletne strani....???
                                 



                                           

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
