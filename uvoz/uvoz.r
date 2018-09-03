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
  pricakovana.zivljenjska.doba <- read_csv("podatki/zivljenjska.doba.csv",
                                           col_names = c("Leto", "Drzava", "Spol", "Starost", "Enota", "Vrednost"),
                                           locale = locale(encoding = "Windows-1250"),
                                           skip = 1,
                                           na= c("", ":")) %>% select(-Enota) %>% drop_na()
  
  pricakovana.zivljenjska.doba$Drzava <- as.factor(pricakovana.zivljenjska.doba$Drzava)
  pricakovana.zivljenjska.doba$Leto <- as.integer(pricakovana.zivljenjska.doba$Leto)
  pricakovana.zivljenjska.doba$Spol <- as.factor(pricakovana.zivljenjska.doba$Spol)
  pricakovana.zivljenjska.doba$Starost <- as.factor(pricakovana.zivljenjska.doba$Starost)
  pricakovana.zivljenjska.doba$Vrednost <- as.numeric(pricakovana.zivljenjska.doba$Vrednost)
  
  #preimenujemo "Germany (until 1990 former territory of the FRG)"v "Germany"
  #in "Former Yugoslav Republic of Macedonia, the" v "Macedonia"
  levels(pricakovana.zivljenjska.doba$Drzava)[17] <- "Germany"
  levels(pricakovana.zivljenjska.doba$Drzava)[14] <- "Macedonia"
  
  return(pricakovana.zivljenjska.doba)
}

pricakovana.zivljenjska.doba <- uvoz.zivljenjska.doba()


#uvoz 2. tabele: izdatki za posamezne funkcije zdravstvene nege
uvoz.funkcije <- function(){
  funkcije.zdravstvene.nege <- read_csv("podatki/funkcije.csv",
                                        col_names = c("Leto", "Drzava","Enota", "Funkcija", "Vrednost"),
                                        locale = locale(encoding = "Windows-1250"),
                                        skip = 1,
                                        na= c("", ":")) %>% select(-Enota) %>% drop_na()
  
  funkcije.zdravstvene.nege$Drzava <- as.factor(funkcije.zdravstvene.nege$Drzava)
  funkcije.zdravstvene.nege$Leto <- as.integer(funkcije.zdravstvene.nege$Leto)
  funkcije.zdravstvene.nege$Funkcija <- as.factor(funkcije.zdravstvene.nege$Funkcija)
  funkcije.zdravstvene.nege$Vrednost <- as.numeric(funkcije.zdravstvene.nege$Vrednost)
  
  levels(funkcije.zdravstvene.nege$Drzava)[11] <- "Germany"
  
  return(funkcije.zdravstvene.nege)
}

funkcije.zdravstvene.nege <- uvoz.funkcije()

#uvoz 3. tabele: Sheme financiranja zdravstvenih storitev
uvoz.shema <- function(){
  shema.financiranja <- read_csv("podatki/shema.csv",
                                 col_names = c("Leto", "Drzava","Enota", "Shema", "Vrednost"),
                                 locale = locale(encoding = "Windows-1250"),
                                 skip = 1,
                                 na= c("", ":")) %>% select(-Enota) %>% drop_na()
  shema.financiranja$Drzava <- as.factor(shema.financiranja$Drzava)
  shema.financiranja$Leto <- as.integer(shema.financiranja$Leto)
  shema.financiranja$Shema <- as.factor(shema.financiranja$Shema)
  shema.financiranja$Vrednost <- as.numeric(shema.financiranja$Vrednost)
  
  levels(shema.financiranja$Drzava)[11] <- "Germany"
  
  return(shema.financiranja)
}

shema.financiranja <- uvoz.shema()

#uvoz 4. tabele: izdatki ponudnikov zdravstvenih storitev
uvoz.ponudniki <- function(){
  link <- "http://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=hlth_sha11_hp&lang=en"
  stran <- POST(link) %>% content(as = "text")
  drzave <- stran %>% strapplyc('var yValues="([^"]+)"') %>% unlist() %>%
    strapplyc("\\|([^|]+)\\|\\|") %>% unlist()
  
  leta <- stran %>% strapplyc('var xValues="([^"]+)"') %>% unlist() %>% 
    strapplyc("\\|TIME([0-9]+)\\|") %>% unlist() %>% parse_number()
  data <- stran %>% strapplyc('var dataValues="([^"]+)"') %>% unlist() %>%
    strapplyc("([^|]+)\\|") %>% unlist() %>%
    parse_number(na = c(":", "(p):", "(d):"),
                 locale = locale(decimal_mark = ".", grouping_mark = ","))
  ponudniki.zdravstvenih.storitev <- data.frame(Drzava = matrix(drzave, byrow = TRUE,
                                                   nrow = length(leta), ncol = length(drzave)) %>% as.vector(),
                                   Leto = leta, Vrednost = data)%>% drop_na()
  
  levels(ponudniki.zdravstvenih.storitev$Drzava)[12] <- "Germany"
  return(ponudniki.zdravstvenih.storitev)
}

ponudniki.zdravstvenih.storitev <- uvoz.ponudniki()

