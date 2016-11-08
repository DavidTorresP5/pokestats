library(shiny)
library(ggplot2)
library(ggExtra)
library(shinythemes)
library(dplyr)
library(tidyr)

data <- read.csv('Pokemon.csv')
data$Generation <- as.factor(data$Generation)



ui <- tagList(
  
  navbarPage(
    theme = shinytheme("flatly"),"PokeStats",
    tabPanel("Home",
             sidebarPanel(
               h4("An app that analyze data from Pokemon"),
               h5("Created by David Torres Pascual (@DavidTweid)"),
               h5("2016")
             ),
             mainPanel(
               img(src="https://s14.postimg.org/tdpnz4d5d/Poke_Stats.png", align = "center"),
               h3("Search a Pokemon"),
               h4("Explore the stats of your favourite Pokemon."),
               h3("Comparison"),
               h4("Compare different attributes based on type, generation or legendary status."),
               h3("Correlation"),
               h4("Analyze the correlation bewteen attributes.")
               
             )
      
    ),
    tabPanel("Search a Pokemon",
             sidebarPanel(
               h4("Introduce the name of the Pokemon"),
               textInput("name", label= "Name:", value = "Venonat")
               ),
             mainPanel(
               h3("Pokémon statistics:"),
               plotOutput("poke")
               )
    ),
    
    tabPanel("Comparison",
             
             sidebarPanel(
               h4("Comparison"),
               h5("Compare different attributes based on type, generation or legendary status"),
               selectInput("variable", "Compare by:",
                           list("Type" = "Type1",
                                "Generation" = "Generation",
                                "Legendary" = "Legendary")),
               
               selectInput("variable2", "Attribute:",
                           list("HP" = "HP", 
                                "Attack" = "Attack", 
                                "Defense" = "Defense",
                                "Special Attack" = "SpAtk",
                                "Special Defense" = "SpDef",
                                "Speed" = "Speed"),
                           selected ="HP")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Comparison",plotOutput("plot")),
                 tabPanel("Histogram",plotOutput("histograma"))
               )
             )
    ),
    
    tabPanel("Correlation",
             sidebarPanel(  
               h4("Correlation"),
               h5("Analyze the correlation bewteen attributes."),
               selectInput("variable3", "Attribute 1:",
                           list("HP" = "HP", 
                                "Attack" = "Attack", 
                                "Defense" = "Defense",
                                "Special Attack" = "SpAtk",
                                "Special Defense" = "SpDef",
                                "Speed" = "Speed"),
                           selected ="Speed"),
               selectInput("variable4", "Attribute 2:",
                           list("HP" = "HP", 
                                "Attack" = "Attack", 
                                "Defense" = "Defense",
                                "Special Attack" = "SpAtk",
                                "Special Defense" = "SpDef",
                                "Speed" = "Speed"),
                           selected ="Attack")
             ),
             
             mainPanel(
               plotOutput("plot2")
               )
             
             
             ),
  
  tabPanel("Information",
    mainPanel(
      h3("Information"),
      h5("This app has been created using data from https://www.kaggle.com/abcsds/pokemon."),
      h5("Thanks to Nintendo, GameFreak, bulbapedia, developers and users.")
    )
  )
))




server <- function(input, output) {
  
  filter1 <- reactive({
    data %>%
    select(Name, HP, Attack, Defense, SpAtk, SpDef, Speed) %>%
    filter(Name %in% as.character(input$name)) %>%
    gather(Clave, Valor) %>%
    slice(2:7)
  })
  
  output$poke <- renderPlot({

    b <- ggplot(filter1(), aes(factor(Clave), as.numeric(Valor)))
    b2 <- b + geom_bar(stat="identity", color="#2F6CB4",fill="#FFCB05") + theme_minimal()
    b3 <- b2 + labs(y = "Points", x = "Attribute")
    print(b3)
  })

  
  output$plot <- renderPlot({
    p <- ggplot(data, aes_string(x=input$variable, y=input$variable2)) #+ coord_flip()
    p2 <- p + geom_boxplot(fill="#FFCB05",colour="#2F6CB4") + theme_minimal() 
    print(p2)
  })
  output$plot2 <- renderPlot({
    f <- ggplot(data, aes_string(x=input$variable3, y=input$variable4)) 
    f2 <- f + geom_jitter(size=4,shape=21,color="#2F6CB4",fill="#FFCB05")
    f3 <-  f2 + geom_smooth(method = lm, colour="#2F6CB4", fill="#2F6CB4") + theme_minimal()
    f4 <- ggMarginal(f3, colour="#2F6CB4")
    print(f4)
  })
  output$histograma <- renderPlot({
    h <- ggplot(data, aes_string(x=input$variable2) )
    h2 <- h + geom_histogram(binwidth = 5, colour="#2F6CB4",fill="#FFCB05") + theme_minimal()
    print(h2)
  })
}

shinyApp(ui = ui, server = server)
