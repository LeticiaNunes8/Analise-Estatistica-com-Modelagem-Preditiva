library(shiny)
library(ggplot2)
library(readxl)

# Carrega o modelo salvo
modelo <- readRDS("modelo.rds")
variavel <- "sumLOC_TOTAL"

# Carrega o dataset para exibir gráficos
dados <- read_excel("dataset_nasa.xlsx")

ui <- fluidPage(
  titlePanel("Previsão de NUMDEFECTS"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("valor", paste("Insira o valor de", variavel), value = 0),
      actionButton("prever", "Calcular previsão"),
      verbatimTextOutput("resultado")
    ),
    
    mainPanel(
      plotOutput("histograma"),
      plotOutput("boxplot"),
      plotOutput("dispersao")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$prever, {
    entrada <- data.frame(sumLOC_TOTAL = input$valor)
    resultado <- predict(modelo, newdata = entrada)
    output$resultado <- renderPrint(resultado)
  })
  
  output$histograma <- renderPlot({
    ggplot(dados, aes(x = sumLOC_TOTAL)) +
      geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", alpha = 0.6) +
      geom_density(color = "red", size = 1) +
      ggtitle("Histograma com Curva de Densidade - sumLoc_TOTAL")
  })
  
  output$boxplot <- renderPlot({
    ggplot(dados, aes(y = sumLOC_TOTAL)) +
      geom_boxplot(fill = "orange") +
      ggtitle("Boxplot - sumLoc_TOTAL")
  })
  
  output$dispersao <- renderPlot({
    ggplot(dados, aes(x = sumLOC_TOTAL, y = NUMDEFECTS)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE, color = "blue") +
      ggtitle("Dispersão: sumLOC_TOTAL vs NUMDEFECTS")
  })
}

shinyApp(ui, server)