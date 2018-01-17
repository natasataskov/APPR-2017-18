library(ggplot2)
library(dplyr)
library(readr)
library(tibble)

evropa <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(continent == "Europe" | sovereignt %in% c("Turkey", "Cyprus"),
                                  long > -30, sovereignt != "Russia")


#pricakovana zivljenjska doba za posamezno drzavo v letu 2015
ggplot() + geom_polygon(data = evropa %>% left_join(pricakovana.zivljenjska.doba %>%
                                                      filter(Cas == 2015, Spol == "Total"),
                                                    by = c("name_long" = "Drzava")),
                        aes(x = long, y = lat, group = group, fill = Vrednost)) +
  coord_map(xlim = c(-25, 45), ylim = c(32, 72))

#za katero funkcijo posamezna drzava nameni najvec denarja
# ggplot() + geom_polygon(data = evropa %>% left_join(funkcije.zdravstvene.nege %>%
#                                                                             filter(Cas == 2015, Spol == "Total"),
#                                                                           by = c("name_long" = "Drzava")),
#                                               summarise(funkcija = max(Funkcija)),
#                                               aes(x = long, y = lat, group = group, fill = Vrednost)) +
#   coord_map(xlim = c(-25, 45), ylim = c(32, 72))