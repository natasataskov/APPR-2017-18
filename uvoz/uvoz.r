#2. faza: Uvoz podatkov

require("readxl")
require("dplyr")
require("readr")
require("tibble")
require("tidyr")
require("httr")
library("httr")
library("gsubfn")

#uvoz 1. tabele: pricakovana zivljenjska doba
uvoz.zivljenjska.doba <- function(){
  pricakovana.zivljenjska.doba <- read_csv("podatki/Zivljenjska.doba.csv",
                                           col_names = c("Leto", "Drzava", "Spol", "Starost", "Enota", "Vrednost"),
                                           locale = locale(encoding = "Windows-1250"),
                                           skip = 1,
                                           na= c("", ":")) %>% select(-Enota) %>% drop_na()
  
  pricakovana.zivljenjska.doba$Drzava <- as.factor(pricakovana.zivljenjska.doba$Drzava)
  pricakovana.zivljenjska.doba$Leto <- as.integer(pricakovana.zivljenjska.doba$Leto)
  pricakovana.zivljenjska.doba$Spol <- as.factor(pricakovana.zivljenjska.doba$Spol)
  pricakovana.zivljenjska.doba$Starost <- as.factor(pricakovana.zivljenjska.doba$Starost)
  pricakovana.zivljenjska.doba$Vrednost <- as.numeric(pricakovana.zivljenjska.doba$Vrednost)
  
  #starosti pretvorimo v stevila
  Starosti <- c(1, 10:19, 2, 20:29, 3, 30:39, 4, 40:49, 5, 50:59, 6, 60:69, 7, 70:79, 8, 80:85, 9, 0)
  starosti <- pricakovana.zivljenjska.doba$Starost
  tab <- data.frame(star.dolge = starosti, star.kratke = Starosti)
  tab$star.dolge <- as.character(tab$star.dolge)
  #tab2 <- pricakovana.zivljenjska.doba %>% inner_join(tab, c("Starost"="star.dolge"))
  #tab2$Starost <- NULL
  #tab2$star.kratke <- Starost
  #tab2$Starost <- as.integer(tab2$Starost)

  #return(tab2)
  
  #pobrisemo vrstice, kjer so drzave, ki niso enake kot v ostalih tabelah
  #v1 <- logical(length(pricakovana.zivljenjska.doba$Drzava))
  #for(i in 1:length(pricakovana.zivljenjska.doba$Drzava)){
  #  v1[i] <- pricakovana.zivljenjska.doba$Drzava[i] %in% funkcije.zdravstvene.nege$Drzava 
  #  }
  #pricakovana.zivljenjska.doba <- pricakovana.zivljenjska.doba[v1,]
  
  return(pricakovana.zivljenjska.doba)
}

pricakovana.zivljenjska.doba <- uvoz.zivljenjska.doba()


#uvoz 2. tabele: izdatki za posamezne funkcije zdravstvene nege
uvoz.funkcije <- function(){
  funkcije.zdravstvene.nege <- read_csv("podatki/Funkcije.csv",
                                        col_names = c("Leto", "Drzava","Enota", "Funkcija", "Vrednost"),
                                        locale = locale(encoding = "Windows-1250"),
                                        skip = 1,
                                        na= c("", ":")) %>% select(-Enota) %>% drop_na()
  
  funkcije.zdravstvene.nege$Drzava <- as.factor(funkcije.zdravstvene.nege$Drzava)
  funkcije.zdravstvene.nege$Leto <- as.integer(funkcije.zdravstvene.nege$Leto)
  funkcije.zdravstvene.nege$Funkcija <- as.factor(funkcije.zdravstvene.nege$Funkcija)
  funkcije.zdravstvene.nege$Vrednost <- as.numeric(funkcije.zdravstvene.nege$Vrednost)
  return(funkcije.zdravstvene.nege)
}

funkcije.zdravstvene.nege <- uvoz.funkcije()

#uvoz 3. tabele: izdatki ponudnikov zdravstvenih storitev
uvoz.ponudniki <- function(){
  ponudniki.zdravstvenih.storitev <- read_csv("podatki/Ponudniki.csv",
                                              col_names = c("Leto", "Drzava","Enota", "Ponudnik", "Vrednost"),
                                              locale = locale(encoding = "Windows-1250"),
                                              skip = 1,
                                              na= c("", ":")) %>% select(-Enota) %>% drop_na()
  
  ponudniki.zdravstvenih.storitev$Drzava <- as.factor(ponudniki.zdravstvenih.storitev$Drzava)
  ponudniki.zdravstvenih.storitev$Leto <- as.integer(ponudniki.zdravstvenih.storitev$Leto)
  ponudniki.zdravstvenih.storitev$Ponudnik <- as.factor(ponudniki.zdravstvenih.storitev$Ponudnik)
  ponudniki.zdravstvenih.storitev$Vrednost <- as.numeric(ponudniki.zdravstvenih.storitev$Vrednost)
  return(ponudniki.zdravstvenih.storitev)
}

ponudniki.zdravstvenih.storitev <- uvoz.ponudniki()

#uvoz 4. tabele: Sheme financiranja zdravstvenih storitev
uvoz.shema <- function(){
  link <- "http://appsso.eurostat.ec.europa.eu/nui/submitViewTableAction.do"
  stran <- POST(link) %>% content(as = "text")
  drzave <- stran %>% strapplyc('var yValues="([^"]+)"') %>% unlist() %>%
    strapplyc("\\|([^|]+)\\|\\|") %>% unlist()
  
  leta <- stran %>% strapplyc('var xValues="([^"]+)"') %>% unlist() %>% 
    strapplyc("\\|TIME([0-9]+)\\|") %>% unlist() %>% parse_number()
  data <- stran %>% strapplyc('var dataValues="([^"]+)"') %>% unlist() %>%
    strapplyc("([^|]+)\\|") %>% unlist() %>%
    parse_number(na = c(":", "(p):", "(d):"),
                 locale = locale(decimal_mark = ".", grouping_mark = ","))
  shema.financiranja <- data.frame(Drzava = matrix(drzave, byrow = TRUE,
                                    nrow = length(leta), ncol = length(drzave)) %>% as.vector(),
                    Leto = leta, Vrednost = data)%>% drop_na()
  return(shema.financiranja)
}

shema.financiranja <- uvoz.shema()