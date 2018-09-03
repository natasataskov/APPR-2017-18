library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(digest)

evropa <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(CONTINENT == "Europe" | SOVEREIGNT %in% c("Turkey", "Cyprus"),
                                  long > -30, SOVEREIGNT != "Russia")


#zemljevid pricakovane zivljenjske dobe za posamezno drzavo v letu 2016
z1 <- ggplot() + geom_polygon(data = evropa %>% left_join(pricakovana.zivljenjska.doba %>%
                                                            filter(Leto == 2016),
                                                          by = c("NAME_LONG" = "Drzava")),
                              aes(x = long, y = lat, group = group, fill = Vrednost)) +
  coord_map(xlim = c(-25, 45), ylim = c(32, 72))


#zemljevid prikazuje, za katero funkcijo posamezna drzva nameni najvec denarja
f <- c("Curative care","Rehabilitative care","Long-term care (health)",
       "Ancillary services (non-specified by function)",
       "Medical goods (non-specified by function)",
       "Preventive care","Governance and health system and financing administration")

z2 <- ggplot() + geom_polygon(data = evropa %>%
                          left_join(funkcije.zdravstvene.nege %>%
                                      filter(Leto == 2015, Funkcija %in% f) %>%
                                      group_by(Drzava) %>% top_n(1, Vrednost),
                                    by = c("NAME_LONG" = "Drzava")),
                        aes(x = long, y = lat, group = group, fill = Funkcija)) +
  coord_map(xlim = c(-25, 45), ylim = c(32, 72))


#tabela drzav, ki imajo najdaljso in najkrajso pricakovano zivljenjsko dobo
t0 <- pricakovana.zivljenjska.doba %>% 
  filter(Leto=="2015", Starost=="Less than 1 year")%>% 
  group_by(Drzava) %>% summarize(Zivlj.doba=mean(Vrednost)) %>% 
  arrange(Zivlj.doba)
najdaljsa <- head(arrange(t0, desc(Zivlj.doba)))
najkrajsa <- head(t0)

#graf pricakovane zivljenjske dobe v casu v vsaki drzavi
t1 <- pricakovana.zivljenjska.doba %>% group_by(Drzava, Leto) %>% 
  summarise(Povprecje=mean(Vrednost))
g1 <- ggplot(t1, aes(x=Leto, 
                     y=Povprecje, color=Drzava)) +
  geom_path() + 
  labs(x="Leto", 
       y="Pricakovana zivljenjska doba")

#graf, koliko eurov na prebivalca je namenila posamezna drzava za zdravstveno
#nego v celoti v casu
t2 <- funkcije.zdravstvene.nege %>% group_by(Drzava, Leto) %>% 
  summarise(Izdatki=sum(Vrednost))

g2 <- ggplot(t2, aes(x=Leto, 
                     y=Izdatki, color=Drzava)) +
  geom_path() + 
  labs(x="Leto", 
       y="Pricakovana zivljenjska doba")


#histogram pricakovane zivljenjske dobe glede na starost
t3 <- pricakovana.zivljenjska.doba %>%
  group_by(Starost) %>% summarise(doba=mean(Vrednost))
g3 <- ggplot(t3, aes(x=Starost,y=doba)) +
  geom_histogram(stat="identity", position="dodge") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))