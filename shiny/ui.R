library(shiny)

shinyUI(fluidPage(
  selectInput(inputId="leto", label="Izberite leto", 
              choices=unique(pricakovana.zivljenjska.doba$Leto), selected= 2015),
  radioButtons(inputId = "spol", label="Izberite spol", 
               choices=c("M" = "Males", "Ž" = "Females")),
  selectInput(inputId="starost", label="Izberite starost", 
              choices=unique(pricakovana.zivljenjska.doba$Starost), 
              multiple = TRUE, selected= "1 year"),
  plotOutput("zivlj"),
  
  
  selectInput(inputId="leto1", label="Izberite leto", 
              choices=unique(funkcije.zdravstvene.nege$Leto), selected= 2015),
  selectInput(inputId="drzava", label="Izberite drzavo", 
              choices=unique(funkcije.zdravstvene.nege$Drzava), 
              multiple = TRUE, selected=funkcije.zdravstvene.nege$Drzava),
  plotOutput("funkc")
  
  
  #selectInput(inputId="leto2", label="Izberite leto", 
  #            choices=unique(shema.financiranja$Leto), selected= 2015),
  #selectInput(inputId="drzava1", label="Izberite drzavo", 
  #            choices=unique(shema.financiranja$Drzava), 
  #            multiple = TRUE, selected=shema.financiranja$Drzava),
  #plotOutput("shema")
))
