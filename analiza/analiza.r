library(ggplot2)

# 4. faza: Analiza podatkov

#tabela drzav, ki imajo najdaljso in najkrajso pricakovano zivljenjsko dobo
t0 <- pricakovana.zivljenjska.doba %>% group_by(Drzava) %>% 
  summarise(Povprecje=mean(Vrednost))
najdaljsa <- head(arrange(t0, desc(Povprecje)))
najkrajsa <- head(arrange(t0, Povprecje))


#graf pricakovane zivljenjske dobe v casu v vsaki drzavi
t1 <- pricakovana.zivljenjska.doba %>% group_by(Drzava, Leto) %>% 
  summarise(Povprecje=mean(Vrednost))
g1 <- ggplot(t1, aes(x=t1$Leto, 
                 y=t1$Povprecje, color=Drzava)) +
  geom_path() + 
  labs(x="Leto", 
       y="Pricakovana zivljenjska doba")

#konkretno samo za Latvijo in Svico
t11 <- filter(t1, Drzava=="Latvia" | Drzava =="Switzerland")
g11 <- ggplot(t11, aes(x=t11$Leto, 
                     y=t11$Povprecje, color=Drzava)) +
  geom_path() + 
  labs(x="Leto", 
       y="Pricakovana zivljenjska doba")


#graf, koliko eurov na prebivalca je namenila posamezna drzava za zdravstveno
#nego v celoti v casu
t2 <- funkcije.zdravstvene.nege %>% group_by(Drzava, Leto) %>% 
  summarise(Izdatki=sum(Vrednost))

g2 <- ggplot(t2, aes(x=t2$Leto, 
                     y=t2$Izdatki, color=Drzava)) +
  geom_path() + 
  labs(x="Leto", 
       y="Pricakovana zivljenjska doba")

#konkretno samo za Latvijo in Svico
t21 <- filter(t2, Drzava=="Latvia" | Drzava =="Switzerland")
g21 <- ggplot(t21, aes(x=t21$Leto, 
                     y=t21$Izdatki, color=Drzava)) +
  geom_path() + 
  labs(x="Leto", 
       y="Pricakovana zivljenjska doba")


#histogram pricakovane zivljenjske dobe glede na starost
t3 <- pricakovana.zivljenjska.doba %>%
  group_by(Starost) %>% summarise(doba=mean(Vrednost))
g3 <- hist(t3$doba, xlab="Starost", ylab="Pricakovana zivljenjska doba",
           main="")

#graf, koliko denarja posamezna drzava nameni za posameznega ponudnika 
#zdravstvenih storitev
t4 <- ponudniki.zdravstvenih.storitev %>% 
  group_by(Ponudnik, Drzava) %>% summarise(povprecje=mean(Vrednost))
g4 <- ggplot(t4, aes(x=t4$Ponudnik, 
                     y=t4$povprecje, color=Drzava)) +
  geom_point() + 
  labs(x="Ponudnik", 
       y="Izdatki")

#konkretno samo za Latvijo in Svico
t41 <- filter(t4, Drzava=="Latvia" | Drzava =="Switzerland")
g41 <- ggplot(t41, aes(x=t41$Ponudnik, 
                     y=t41$povprecje, color=Drzava)) +
  geom_point() + 
  labs(x="Ponudnik", 
       y="Izdatki")
