library(ggplot2)

# 4. faza: Analiza podatkov

#tabela drzav, razvrscenih po pricakovani zivljenjski dobi
t0 <- pricakovana.zivljenjska.doba %>% 
  filter(Leto=="2015", Starost=="Less than 1 year")%>% 
  group_by(Drzava) %>% summarize(Zivlj.doba=mean(Vrednost)) %>% 
  arrange(Zivlj.doba)

#tabela prikazuje, koliko eurov na prebivalca posamezna drzava zapravi na 
#leto pricakovane zivljenjske dobe
t50 <- funkcije.zdravstvene.nege %>%
filter(Leto=="2015", Funkcija=="Current health care expenditure (CHE)") %>% 
  group_by(Drzava)
t51 <- t50 %>% inner_join(t0, by="Drzava")
t51$Letni.izdatki <- t51$Vrednost/t51$Zivlj.doba
t5 <- t51 %>% select(Drzava, Izdatki=Vrednost, Zivlj.doba, Letni.izdatki)
t5 <- arrange(t5, Letni.izdatki)

#posebej si poglejmo za nekaj drzav z najdaljso zivljenjsko dobo in nekaj drzav z
#najkrajso zivljenjsko dobo
drzave <- c("Lithuania", "Latvia", "Bulgaria", "Romania", 
            "Spain", "Liechtenstein", "Italy", "Iceland")
t52 <- t5 %>% filter(Drzava %in% drzave)
g5 <- ggplot(t52, aes(x=reorder(Drzava,Zivlj.doba), y=Letni.izdatki)) + geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  xlab("Država") + ylab("Letni izdatki")



#prejsnji tabeli se dodamo, koliko odstotkov izdatkov za zdravstvene storitve
#posamezna drzava nameni za posamezno shemo financiranja
gl.sheme <- c("Government schemes and compulsory contributory health care financing schemes",
              "Voluntary health care payment schemes",
              "Household out-of-pocket payment",
              "Rest of the world financing schemes (non-resident)")
t60 <- shema.financiranja %>% filter(Leto==2015, Shema %in% gl.sheme) %>% 
  group_by(Drzava)
t60$Leto <- NULL
s<-shema.financiranja %>% filter(Leto==2015, Shema=="All financing schemes") %>%
  select(Drzava, Vsota=Vrednost)
t61<- t60 %>% inner_join(s, by="Drzava")
t61$Delez <- t61$Vrednost/t61$Vsota
t6 <- t5 %>% inner_join(t61, by="Drzava")
t6$Vsota <- NULL

#graf letnih izdatkov na leto zivljenja glede na pricakovano zivljenjsko dobo 
#za posamezne drzave
g6 <-  ggplot(t6, aes(x=Zivlj.doba, y=Letni.izdatki, label=Drzava)) +
  geom_point() + geom_text(aes(label=Drzava),hjust=1, vjust=1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  xlab("Življenjska doba") + ylab("Izdatki za zdravstvo na leto življenja")


#histogram prikazuje, koliko odstotkov nameni posamezna od izbranih drzav za 
#posamezno shemo financiranja
t62 <- t6 %>% filter(Drzava %in% drzave)

g7<- ggplot(t62, aes(x=reorder(Drzava,Zivlj.doba),y=Delez,fill=substring(Shema,2))) +
  geom_histogram(stat="identity", position="dodge") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  xlab("Država") + ylab("Delež") + guides(fill = guide_legend("Shema")) +
  theme(legend.position="bottom")




