# ---------------------------------------------------------
# Proyecto: Scouting Híbrido - Aplicación con Goles y Pases (HMTL)
# ---------------------------------------------------------

if(!require(shiny)) install.packages("shiny")
if(!require(shinythemes)) install.packages("shinythemes")
if(!require(rmarkdown)) install.packages("rmarkdown")
library(shiny)
library(shinythemes)
library(rmarkdown)

# Base de datos simulada del club
datos_jugadores <- data.frame(
  jugador           = c("Delantero A", "Mediocentro B", "Extremo C", "Central D", "Interior E"),
  goles_poisson     = c(0.42, 0.12, 0.35, 0.05, 0.18),
  pases_normalizados = c(22, 58, 31, 45, 40),
  resiliencia_score = c(85, 90, 30, 45, 70),
  riesgo_desarraigo = c("Bajo", "Bajo", "Alto", "Alto", "Medio")
)

# INTERFAZ DE USUARIO (UI)
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("📊 Panel de Scouting Híbrido: Rendimiento + Psicología"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Filtros de Selección"),
      selectInput("selector_jugador", "Selecciona un Candidato:", choices = datos_jugadores$jugador),
      hr(),
      downloadButton("descargar_reporte", "Generar Informe Digital", class = "btn-success"),
      p(style = "margin-top: 15px;", "Haga clic para exportar la ficha psicosocial completa en formato HTML.")
    ),
    
    mainPanel(
      h3("Reporte en Tiempo Real del Jugador"),
      fluidRow(
        column(4, wellPanel(h4("Métricas de Cancha"), uiOutput("metrica_futbol"))),
        column(4, wellPanel(h4("Métricas Humanas"), uiOutput("metrica_psico"))),
        column(4, wellPanel(h4("Veredicto del Algoritmo"), uiOutput("metrica_decision")))
      )
    )
  )
)

# LÓGICA DEL SERVIDOR (SERVER)
server <- function(input, output) {
  
  datos_filtrados <- reactive({
    subset(datos_jugadores, jugador == input.selector_jugador)
  })
  
  output$metrica_futbol <- renderUI({
    df <- datos_filtrados()
    tagList(
      p(strong("Probabilidad de Gol (Poisson):")),
      h3(paste0(df$goles_poisson * 100, "%"), style = "color: #2c3e50; margin-bottom: 15px;"),
      p(strong("Pases Completados por Partido:")),
      h3(df$pases_normalizados, style = "color: #2c3e50;")
    )
  })
  
  output$metrica_psico <- renderUI({
    df <- datos_filtrados()
    tagList(
      p(strong("Puntaje de Resiliencia:")), h4(paste0(df$resiliencia_score, " / 100")),
      p(strong("Riesgo de Desarraigo:")), h4(df$riesgo_desarraigo, style = ifelse(df$riesgo_desarraigo == "Alto", "color: red;", "color: green;"))
    )
  })
  
  output$metrica_decision <- renderUI({
    df <- datos_filtrados()
    
    # Reglas lógicas lógicas directas del Árbol de Decisión simulado
    prediccion <- "Monitorear"
    if (df$resiliencia_score < 40 || df$riesgo_desarraigo == "Alto") {
      prediccion <- "Descartar"
    } else if (df$resiliencia_score >= 80 && df$goles_poisson > 0.10) {
      prediccion <- "Fichar"
    }
    
    color_veredicto <- switch(prediccion, "Fichar" = "#27ae60", "Monitorear" = "#f39c12", "Descartar" = "#c0392b")
    tagList(p(strong("Recomendación:")), h2(prediccion, style = paste0("color: ", color_veredicto, "; font-weight: bold;")))
  })
  
  output$descargar_reporte <- downloadHandler(
    filename = function() { paste0("Reporte_Scouting_", input$selector_jugador, ".html") },
    content = function(file) {
      df <- datos_filtrados()
      
      prediccion <- "Monitorear"
      if (df$resiliencia_score < 40 || df$riesgo_desarraigo == "Alto") {
        prediccion <- "Descartar"
      } else if (df$resiliencia_score >= 80 && df$goles_poisson > 0.10) {
        prediccion <- "Fichar"
      }
      
      params <- list(
        jugador = input$selector_jugador,
        poisson = paste0(df$goles_poisson * 100, "%"),
        pases = df$pases_normalizados,
        resiliencia = df$resiliencia_score,
        desarraigo = df$riesgo_desarraigo,
        veredicto = prediccion
      )
      
      rmarkdown::render("plantilla_reporte.Rmd", output_file = file,
                        params = params, envir = new.env(parent = globalenv()))
    }
  )
}

shinyApp(ui = ui, server = server)
