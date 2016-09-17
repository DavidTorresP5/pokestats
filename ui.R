library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Atributos de Pokemon"),
  
  sidebarPanel(
    radioButtons("variable1", "Comparar por:",
                list("Tipo" = "Type1", 
                     "Generación" = "Generation", 
                     "Legendario" = "Legendary")),
    radioButtons("variable2", "Atributo:",
                list("HP" = "HP", 
                     "Ataque" = "Attack", 
                     "Defensa" = "Defense",
                     "Ataque Especial" = "SpAtk",
                     "Defensa Especial" = "SpDef",
                     "Velocidad" = "Speed")),
    checkboxInput("outliers", "Mostrar outliers", FALSE)
    ),
  
  mainPanel(
    plotOutput("plot1")
  )
))