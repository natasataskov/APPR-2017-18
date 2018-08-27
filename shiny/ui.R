library(shiny)

shinyUI(fluidPage(
  selectInput(inputId="leto", label="Izberite leto", 
              choices=pricakovana.zivljenjska.doba$Leto, selected= 2007),
  radioButtons(inputId = "spol", label="Izberite spol", choices=c("M", "Ž")),
  selectInput(inputId="starost", label="Izberite starost", 
              choices=pricakovana.zivljenjska.doba$Starost, multiple = TRUE, selected= "1 year"),
  plotOutput("zivlj1")

))
