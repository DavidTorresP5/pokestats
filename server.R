df <- read.csv('Pokemon.csv')

shinyServer(function(input, output) {
  formulaText <- reactive({
    paste(input$variable2, "~", input$variable1)
  })

  output$plot1 <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = df,
            las = 2,
            outline = input$outliers,
            #xlab=input$variable1, 
            ylab=input$variable2,
            col = "#2980b9")
  })
})