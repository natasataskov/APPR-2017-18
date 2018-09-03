library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  output$zivlj <- renderPlot({
    data <- pricakovana.zivljenjska.doba %>% filter(Leto %in% input$leto, 
                                                    Spol %in% input$spol,
                                                    Starost %in% input$starost)
    ggplot(data, aes(x=Drzava, y=Vrednost, color=Starost)) +
      geom_point() + 
      labs(xlab="Drzava", 
           ylab="Pricakovana zivljenjska doba") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  })
  
  output$funkc <- renderPlot({
    data <- funkcije.zdravstvene.nege %>% filter(Leto %in% input$leto1, 
                                                    Drzava %in% input$drzava)
    ggplot(data, aes(x=Funkcija, y=Vrednost, color=Drzava)) +
      geom_point() + 
      labs(xlab="Funkcija", 
           ylab="Izdatki") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  })
  
  #output$shema <- renderPlot({
  #  data <- shema.financiranja %>% filter(Leto %in% input$leto2, 
  #                                                  Drzava %in% input$drzava1)
  #  ggplot(data, aes(x=Shema, y=Vrednost, color=Drzava)) +
  #    geom_point() + 
  #    labs(xlab="Shema", 
  #         ylab="Izdatki") +
  #    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  #})
  
})


