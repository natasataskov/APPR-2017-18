library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  output$zivlj1 <- renderPlot({
    data <- pricakovana.zivljenjska.doba %>% filter(pricakovana.zivljenjska.doba$Leto==input$leto, 
                                                    pricakovana.zivljenjska.doba$Spol==input$spol,
                                                    pricakovana.zivljenjska.doba$Starost==input$starost)
    ggplot(data, aes(x=data$Drzava, y=data$Vrednost)) +geom_point() + 
      labs(xlab="Drzava", 
           ylab="Pricakovana zivljenjska doba")
  })
})


