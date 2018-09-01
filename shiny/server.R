library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  output$zivlj1 <- renderPlot({
    data <- pricakovana.zivljenjska.doba %>% filter(Leto %in% input$leto, 
                                                    Spol %in% input$spol,
                                                    Starost %in% input$starost)
    ggplot(data, aes(x=Drzava, y=Vrednost, color=Starost)) +
      geom_point() + 
      labs(xlab="Drzava", 
           ylab="Pricakovana zivljenjska doba") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  })
})


