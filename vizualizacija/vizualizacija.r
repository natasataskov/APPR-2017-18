library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(digest)

evropa <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(CONTINENT == "Europe" | SOVEREIGNT %in% c("Turkey", "Cyprus"),
                                  long > -30, SOVEREIGNT != "Russia")


#pricakovana zivljenjska doba za posamezno drzavo v letu 2015
ggplot() + geom_polygon(data = evropa %>% left_join(pricakovana.zivljenjska.doba %>%
                                                      filter(Čas == 2015, Spol == "Total"),
                                                    by = c("NAME_LONG" = "Država")),
                        aes(x = long, y = lat, group = group, fill = Vrednost)) +
  coord_map(xlim = c(-25, 45), ylim = c(32, 72))

#za katero funkcijo posamezna drzva nameni najvec denarja
ggplot() + geom_polygon(data = evropa %>% left_join(funkcije.zdravstvene.nege %>%
                            filter(Čas == 2015, Spol == "Total"),
                            by = c("name_long" = "Država")),
                            summarise(funkcija = max(Funkcija)),
                             aes(x = long, y = lat, group = group, fill = Vrednost)) +
   coord_map(xlim = c(-25, 45), ylim = c(32, 72))