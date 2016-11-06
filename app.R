library(shiny)
library(ggplot2)
library(ggExtra)
library(shinythemes)
library(dplyr)

data <- read.csv('Pokemon.csv')
data$Generation <- as.factor(data$Generation)



ui <- tagList(
  
  navbarPage(
    theme = shinytheme("flatly"),"PokeStats",
    tabPanel("Inicio",
             mainPanel(
               img(src="PokeStats.png")
             )
      
    ),
    
    
    tabPanel("Comparación de atributos",
             
             sidebarPanel(
               h4("Comparar atributos de tipos de Pokemon"),
               h5("En este apartado puedes comparar los atributos de los 
                  diferentes pokémon según su tipo, generación o entre 
                  legendario/no legendario"),
               selectInput("variable", "Comparar por:",
                           list("Tipo" = "Type1",
                                "Generación" = "Generation",
                                "Legendario" = "Legendary")),
               
               selectInput("variable2", "Atributo a comparar:",
                           list("HP" = "HP", 
                                "Ataque" = "Attack", 
                                "Defensa" = "Defense",
                                "Ataque Especial" = "SpAtk",
                                "Defensa Especial" = "SpDef",
                                "Velocidad" = "Speed"),
                           selected ="HP")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Comparación",plotOutput("plot")),
                 tabPanel("Histograma del atributo",plotOutput("histograma"))
               )
             )
    ),
    
    tabPanel("Correlación de atributos",
             sidebarPanel(  
               h4("Correlación entre atributos"),
               h5("En este apartado puedes analizar la correlación entre
                  diferentes atributos."),
               selectInput("variable3", "Atributo 1:",
                           list("HP" = "HP", 
                                "Ataque" = "Attack", 
                                "Defensa" = "Defense",
                                "Ataque Especial" = "SpAtk",
                                "Defensa Especial" = "SpDef",
                                "Velocidad" = "Speed"),
                           selected ="Speed"),
               selectInput("variable4", "Atributo 2:",
                           list("HP" = "HP", 
                                "Ataque" = "Attack", 
                                "Defensa" = "Defense",
                                "Ataque Especial" = "SpAtk",
                                "Defensa Especial" = "SpDef",
                                "Velocidad" = "Speed"),
                           selected ="Attack")
             ),
             
             mainPanel(
               plotOutput("plot2")
               )
             
             
             ),
  
  tabPanel("Información",
    mainPanel(
      h3("Información"),
      h5("Esta aplicación está realizada con datos procedentes de https://www.kaggle.com/abcsds/pokemon.
        Gracias a Nintendo, GameFreak, bulbapedia y a todos los desarrolladores y usuarios.")
    )
)
)
)



server <- function(input, output) {
  
  
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