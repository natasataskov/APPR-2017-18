#2. faza: Uvoz podatkov

require("readxl")
require("dplyr")
require("readr")
require("tibble")
require("tidyr")

#uvoz 1. tabele: pricakovana zivljenjska doba
uvoz.zivljenjska.doba <- function(){
  pricakovana.zivljenjska.doba <- read_csv("podatki/zivljenjska.doba.csv",
                                           col_names = c("Cas", "Drzava", "Spol", "Starost", "Enota", "Vrednost", "Opombe"),
                                           locale = locale(encoding = "Windows-1250"),
                                           skip = 1,
                                           na= c("", ":")) %>% select(-Enota, -Opombe, -Starost) %>% drop_na()
  
  #pricakovana.zivljenjska.doba$Drzava <- as.factor(pricakovana.zivljenjska.doba$Drzava)
  #pricakovana.zivljenjska.doba$Cas <- as.integer(pricakovana.zivljenjska.doba$Cas)
  #pricakovana.zivljenjska.doba$Spol <- as.factor(pricakovana.zivljenjska.doba$Spol)
  #pricakovana.zivljenjska.doba$Vrednost <- as.numeric(pricakovana.zivljenjska.doba$Vrednost)
  return(pricakovana.zivljenjska.doba)
}

pricakovana.zivljenjska.doba <- uvoz.zivljenjska.doba()


#uvoz 2. tabele: izdatki za posamezne funkcije zdravstvene nege
uvoz.funkcije <- function(){
  funkcije.zdravstvene.nege <- read_csv("podatki/funkcije.csv",
                                        col_names = c("Cas", "Drzava","Enota", "Funkcija", "Vrednost", "Opombe"),
                                        locale = locale(encoding = "Windows-1250"),
                                        skip = 1,
                                        na= c("", ":")) %>% select(-Enota, -Opombe) %>% drop_na()
  
  funkcije.zdravstvene.nege$Drzava <- as.factor(funkcije.zdravstvene.nege$Drzava)
  funkcije.zdravstvene.nege$Cas <- as.integer(funkcije.zdravstvene.nege$Cas)
  funkcije.zdravstvene.nege$Funkcija <- as.factor(funkcije.zdravstvene.nege$Funkcija)
  funkcije.zdravstvene.nege$Vrednost <- as.numeric(funkcije.zdravstvene.nege$Vrednost)
  return(funkcije.zdravstvene.nege)
}

funkcije.zdravstvene.nege <- uvoz.funkcije()

#uvoz 3. tabele: izdatki ponudnikov zdravstvenih storitev
uvoz.ponudniki <- function(){
  ponudniki.zdravstvenih.storitev <- read_csv("podatki/ponudniki.csv",
                                              col_names = c("Cas", "Drzava","Enota", "Ponudnik", "Vrednost", "Opombe"),
                                              locale = locale(encoding = "Windows-1250"),
                                              skip = 1,
                                              na= c("", ":")) %>% select(-Enota, -Opombe) %>% drop_na()
  
  ponudniki.zdravstvenih.storitev$Drzava <- as.factor(ponudniki.zdravstvenih.storitev$Drzava)
  ponudniki.zdravstvenih.storitev$Cas <- as.integer(ponudniki.zdravstvenih.storitev$Cas)
  ponudniki.zdravstvenih.storitev$Ponudnik <- as.factor(ponudniki.zdravstvenih.storitev$Ponudnik)
  ponudniki.zdravstvenih.storitev$Vrednost <- as.numeric(ponudniki.zdravstvenih.storitev$Vrednost)
  return(ponudniki.zdravstvenih.storitev)
}

ponudniki.zdravstvenih.storitev <- uvoz.ponudniki()

#uvoz 4. tabele: Sheme financiranja zdravstvenih storitev
require("httr")
library("httr")
link <- "http://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=hlth_sha11_hf&lang=en"
stran <- POST(link) %>% content(as = "text")
drzave <- stran %>% strapplyc('var yValues="([^"]+)"') %>% unlist() %>%
  strapplyc("\\|([^|]+)\\|\\|") %>% unlist()

leta <- stran %>% strapplyc('var xValues="([^"]+)"') %>% unlist() %>%
  strapplyc("\\|TIME([0-9]+)\\|") %>% unlist() %>% parse_number()
data <- stran %>% strapplyc('var dataValues="([^"]+)"') %>% unlist() %>%
  strapplyc("([^|]+)\\|") %>% unlist() %>%
  parse_number(na = c(":", "(p):", "(d):"),
               locale = locale(decimal_mark = ".", grouping_mark = ","))
tab <- data.frame(drzava = matrix(drzave, byrow = TRUE,
                                  nrow = length(leta), ncol = length(drzave)) %>% as.vector(),
                  leto = leta, vrednost = data)