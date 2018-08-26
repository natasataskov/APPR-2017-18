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
                                           col_names = c("Čas", "Država", "Spol", "Starost", "Enota", "Vrednost"),
                                           locale = locale(encoding = "Windows-1250"),
                                           skip = 1,
                                           na= c("", ":")) %>% select(-Enota) %>% drop_na()
  
  pricakovana.zivljenjska.doba$Država <- as.factor(pricakovana.zivljenjska.doba$Država)
  pricakovana.zivljenjska.doba$Čas <- as.integer(pricakovana.zivljenjska.doba$Čas)
  pricakovana.zivljenjska.doba$Spol <- as.factor(pricakovana.zivljenjska.doba$Spol)
  pricakovana.zivljenjska.doba$Vrednost <- as.numeric(pricakovana.zivljenjska.doba$Vrednost)
  return(pricakovana.zivljenjska.doba)
}

pricakovana.zivljenjska.doba <- uvoz.zivljenjska.doba()


#uvoz 2. tabele: izdatki za posamezne funkcije zdravstvene nege
uvoz.funkcije <- function(){
  funkcije.zdravstvene.nege <- read_csv("podatki/Funkcije.csv",
                                        col_names = c("Čas", "Država","Enota", "Funkcija", "Vrednost"),
                                        locale = locale(encoding = "Windows-1250"),
                                        skip = 1,
                                        na= c("", ":")) %>% select(-Enota) %>% drop_na()
  
  funkcije.zdravstvene.nege$Država <- as.factor(funkcije.zdravstvene.nege$Država)
  funkcije.zdravstvene.nege$Čas <- as.integer(funkcije.zdravstvene.nege$Čas)
  funkcije.zdravstvene.nege$Funkcija <- as.factor(funkcije.zdravstvene.nege$Funkcija)
  funkcije.zdravstvene.nege$Vrednost <- as.numeric(funkcije.zdravstvene.nege$Vrednost)
  return(funkcije.zdravstvene.nege)
}

funkcije.zdravstvene.nege <- uvoz.funkcije()

#uvoz 3. tabele: izdatki ponudnikov zdravstvenih storitev
uvoz.ponudniki <- function(){
  ponudniki.zdravstvenih.storitev <- read_csv("podatki/Ponudniki.csv",
                                              col_names = c("Čas", "Država","Enota", "Ponudnik", "Vrednost"),
                                              locale = locale(encoding = "Windows-1250"),
                                              skip = 1,
                                              na= c("", ":")) %>% select(-Enota) %>% drop_na()
  
  ponudniki.zdravstvenih.storitev$Država <- as.factor(ponudniki.zdravstvenih.storitev$Država)
  ponudniki.zdravstvenih.storitev$Čas <- as.integer(ponudniki.zdravstvenih.storitev$Čas)
  ponudniki.zdravstvenih.storitev$Ponudnik <- as.factor(ponudniki.zdravstvenih.storitev$Ponudnik)
  ponudniki.zdravstvenih.storitev$Vrednost <- as.numeric(ponudniki.zdravstvenih.storitev$Vrednost)
  return(ponudniki.zdravstvenih.storitev)
}

ponudniki.zdravstvenih.storitev <- uvoz.ponudniki()

#uvoz 4. tabele: Sheme financiranja zdravstvenih storitev
uvoz.shema <- function(){
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
  shema.financiranja <- data.frame(Država = matrix(drzave, byrow = TRUE,
                                    nrow = length(leta), ncol = length(drzave)) %>% as.vector(),
                    Leto = leta, Vrednost = data)%>% drop_na()
  return(shema.financiranja)
  }
