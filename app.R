# ---------------------------------------------------------
# Proyecto: Scouting Híbrido - Aplicación con Goles y Pases (HMTL)
# ---------------------------------------------------------

if(!require(shiny)) install.packages("shiny")
if(!require(shinythemes)) install.packages("shinythemes")
library(shiny)
library(shinythemes)

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
      p("Utilice el selector para evaluar de forma interactiva el perfil de cada jugador en tiempo real.")
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
    
    # Reglas lógicas del Árbol de Decisión
    prediccion <- "Monitorear"
    if (df$resiliencia_score < 40 || df$riesgo_desarraigo == "Alto") {
      prediccion <- "Descartar"
    } else if (df$resiliencia_score >= 80 && df$goles_poisson > 0.10) {
      prediccion <- "Fichar"
    }
    
    color_veredicto <- switch(prediccion, "Fichar" = "#27ae60", "Monitorear" = "#f39c12", "Descartar" = "#c0392b")
    tagList(p(strong("Recomendación:")), h2(prediccion, style = paste0("color: ", color_veredicto, "; font-weight: bold;")))
  })
}

shinyApp(ui = ui, server = server)
