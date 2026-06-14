
# ---------------------------------------------------------
# Proyecto: Scouting Híbrido - Versión Final con Exportación PDF Estable
# ---------------------------------------------------------

if(!require(shiny)) install.packages("shiny")
if(!require(shinythemes)) install.packages("shinythemes")
if(!require(pagedown)) install.packages("pagedown") # Para exportar PDF sin LaTeX
library(shiny)
library(shinythemes)
library(pagedown)

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
      # BOTÓN ACTUALIZADO PARA INFORME PDF
      downloadButton("descargar_reporte", "Descargar Reporte PDF", class = "btn-success"),
      p(style = "margin-top: 15px;", "Haga clic para exportar la ficha psicosocial completa en formato PDF ejecutivo.")
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
    subset(datos_jugadores, jugador == input$selector_jugador)
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
    
    prediccion <- "Monitorear"
    if (df$resiliencia_score < 40 || df$riesgo_desarraigo == "Alto") {
      prediccion <- "Descartar"
    } else if (df$resiliencia_score >= 80 && df$goles_poisson > 0.10) {
      prediccion <- "Fichar"
    }
    
    color_veredicto <- switch(prediccion, "Fichar" = "#27ae60", "Monitorear" = "#f39c12", "Descartar" = "#c0392b")
    tagList(p(strong("Recomendación:")), h2(prediccion, style = paste0("color: ", color_veredicto, "; font-weight: bold;")))
  })
  
  # MANEJADOR DE DESCARGA PDF ESTABLE MEDIANTE PAGEDOWN
  output$descargar_reporte <- downloadHandler(
    filename = function() {
      paste0("Ficha_Scouting_", input$selector_jugador, ".pdf") # Salida final en .pdf
    },
    content = function(file) {
      df <- datos_filtrados()
      
      prediccion <- "Monitorear"
      if (df$resiliencia_score < 40 || df$riesgo_desarraigo == "Alto") {
        prediccion <- "Descartar"
      } else if (df$resiliencia_score >= 80 && df$goles_poisson > 0.10) {
        prediccion <- "Fichar"
      }
      
      # 1. Crear el diseño estructurado en HTML para el PDF
      html_temp <- tempfile(fileext = ".html")
      html_content <- paste0(
        "<html><head><title>Reporte Ejecutivo</title>",
        "<style>body { font-family: Arial, sans-serif; margin: 40px; color: #2c3e50; } ",
        "h1 { color: #2c3e50; border-bottom: 2px solid #ecf0f1; padding-bottom: 10px; } ",
        ".box { padding: 15px; background: #f8f9fa; border-left: 5px solid #3498db; margin-bottom: 15px; } ",
        ".decision { font-size: 24px; font-weight: bold; color: ", 
        ifelse(prediccion == "Fichar", "#27ae60", ifelse(prediccion == "Descartar", "#c0392b", "#f39c12")), "; }</style></head>",
        "<body>",
        "<h1>📋 Reporte Ejecutivo de Dirección Deportiva</h1>",
        "<h2>Candidato Evaluado: ", input$selector_jugador, "</h2>",
        "<hr>",
        "<div class='box'>",
        "<h3>1. Métricas Técnicas de Cancha</h3>",
        "<p><strong>Frecuencia de Gol (Poisson):</strong> ", df$goles_poisson * 100, "%</p>",
        "<p><strong>Volumen de Juego (Pases Completados):</strong> ", df$pases_normalizados, " pases/90min</p>",
        "</div>",
        "<div class='box'>",
        "<h3>2. Evaluación de Perfil Psicosocial</h3>",
        "<p><strong>Puntaje de Resiliencia Conductual:</strong> ", df$resiliencia_score, " / 100</p>",
        "<p><strong>Riesgo de Desarraigo Geográfico:</strong> ", df$riesgo_desarraigo, "</p>",
        "</div>",
        "<hr>",
        "<h3>🎯 Veredicto Final del Sistema Híbrido</h3>",
        "<p class='decision'>RECOMENDACIÓN: ", prediccion, "</p>",
        "<p style='font-size: 12px; color: #7f8c8d; margin-top: 30px;'>*Documento confidencial automatizado para uso exclusivo de la junta deportiva.</p>",
        "</body></html>"
      )
      writeLines(html_content, html_temp)
      
      # 2. Convertir el HTML a PDF real usando pagedown de manera nativa en la nube
      pagedown::chrome_print(input = html_temp, output = file, options = list(transferMode = "ReturnAsBase64"))
    }
  )
}

shinyApp(ui = ui, server = server)
