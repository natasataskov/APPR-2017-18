library(shiny)

shinyUI(fluidPage(
  selectInput(inputId="leto", label="Izberite leto", 
              choices=unique(pricakovana.zivljenjska.doba$Leto), selected= 2007),
  radioButtons(inputId = "spol", label="Izberite spol", 
               choices=c("M" = "Males", "Ž" = "Females")),
  selectInput(inputId="starost", label="Izberite starost", 
              choices=unique(pricakovana.zivljenjska.doba$Starost), 
              multiple = TRUE, selected= "1 year"),
  plotOutput("zivlj1")
  
))
