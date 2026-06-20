# ---------------------------------------------------------
# Proyecto: Scouting Híbrido - Versión HTML Imprimible + Alimentación Dinámica
# ---------------------------------------------------------

if(!require(shiny)) install.packages("shiny")
if(!require(shinythemes)) install.packages("shinythemes")
if(!require(readxl)) install.packages("readxl") # 👈 NUEVA: Requerida para leer archivos de Excel

library(shiny)
library(shinythemes)
library(readxl)

# Base de datos simulada del club (Actúa como la base inicial)
datos_jugadores_base <- data.frame(
  jugador           = c("Delantero A", "Mediocentro B", "Extremo C", "Central D", "Interior E"),
  goles_poisson     = c(0.42, 0.12, 0.35, 0.05, 0.18),
  pases_normalizados = c(22, 58, 31, 45, 40),
  resiliencia_score = c(85, 90, 30, 45, 70),
  riesgo_desarraigo = c("Bajo", "Bajo", "Alto", "Alto", "Medio"),
  stringsAsFactors  = FALSE
)

# INTERFAZ DE USUARIO (UI)
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("📊 Panel de Scouting Híbrido: Rendimiento + Psicología"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Filtros de Selección"),
      # El menú desplegable ahora se inicializa vacío y el servidor lo llena dinámicamente
      selectInput("selector_jugador", "Selecciona un Candidato:", choices = NULL),
      hr(),
      
      # 📥 NUEVA SECCIÓN: CARGA DE DATOS EXTERNOS
      h4("Alimentar Base de Datos"),
      fileInput("archivo_nuevo", "Subir nuevos prospectos (.csv, .xlsx)", 
                accept = c(".csv", ".xlsx")),
      actionButton("reentrenar", "Integrar y Actualizar Lista", 
                   class = "btn-primary", icon = icon("refresh")),
      hr(),
      
      # BOTÓN CONFIGURADO PARA EXPORTACIÓN DIRECTA
      downloadButton("descargar_reporte", "Exportar Reporte PDF", class = "btn-success"),
      p(style = "margin-top: 15px;", "Haga clic para descargar el archivo técnico y guardarlo directamente como PDF.")
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
server <- function(input, output, session) { # 👈 Agregado 'session' para permitir actualizaciones dinámicas
  
  # 1. Almacenamiento reactivo de la base de datos (permite modificaciones en vivo)
  valores <- reactiveValues(data_total = datos_jugadores_base)
  
  # 2. Rellenar el desplegable por primera vez al iniciar la aplicación
  observe({
    updateSelectInput(session, "selector_jugador", choices = valores$data_total$jugador)
  })
  
  # 3. Lógica de lectura reactiva para procesar el archivo subido
  datos_subidos <- reactive({
    req(input$archivo_nuevo)
    ruta <- input$archivo_nuevo$datapath
    extension <- tools::file_ext(input$archivo_nuevo$name)
    
    if (extension == "csv") {
      df <- read.csv(ruta, stringsAsFactors = FALSE)
    } else if (extension %in% c("xls", "xlsx")) {
      df <- readxl::read_excel(ruta)
    } else {
      showNotification("Formato inválido. Sube un archivo .csv o .xlsx", type = "error")
      return(NULL)
    }
    return(df)
  })
  
  # 4. Validación estricta y fusión de datos al presionar el botón "Integrar"
  observeEvent(input$reentrenar, {
    req(datos_subidos())
    nuevos_datos <- datos_subidos()
    
    # Columnas exactas que exige tu lógica del sistema para no romperse
    columnas_requeridas <- c("jugador", "goles_poisson", "pases_normalizados", "resiliencia_score", "riesgo_desarraigo")
    
    # Verificar si falta alguna columna en el archivo del usuario
    columnas_faltantes <- setdiff(columnas_requeridas, colnames(nuevos_datos))
    
    if (length(columnas_faltantes) > 0) {
      # Muestra advertencia interactiva y detiene la fusión
      showModal(modalDialog(
        title = "⚠️ Estructura de archivo incorrecta",
        paste("Al archivo le faltan las siguientes columnas obligatorias:", 
              paste(columnas_faltantes, collapse = ", ")),
        easyClose = TRUE,
        footer = modalButton("Entendido")
      ))
      return() 
    }
    
    # Extraer únicamente las columnas requeridas (ignora columnas basura adicionales)
    nuevos_datos_limpios <- nuevos_datos[, columnas_requeridas]
    
    # Forzar conversión de tipos para evitar errores de combinación al hacer rbind
    nuevos_datos_limpios$jugador <- as.character(nuevos_datos_limpios$jugador)
    nuevos_datos_limpios$goles_poisson <- as.numeric(nuevos_datos_limpios$goles_poisson)
    nuevos_datos_limpios$pases_normalizados <- as.numeric(nuevos_datos_limpios$pases_normalizados)
    nuevos_datos_limpios$resiliencia_score <- as.numeric(nuevos_datos_limpios$resiliencia_score)
    nuevos_datos_limpios$riesgo_desarraigo <- as.character(nuevos_datos_limpios$riesgo_desarraigo)
    
    # Fusionar la base de datos vieja con los registros nuevos
    valores$data_total <- rbind(valores$data_total, nuevos_datos_limpios)
    
    # Actualizar dinámicamente el selector desplegable con la lista expandida
    updateSelectInput(session, "selector_jugador", choices = valores$data_total$jugador)
    
    showNotification("¡Nuevos prospectos integrados con éxito!", type = "message")
  })
  
  # 5. Filtrado de datos consumiendo el entorno reactivo expandible
  datos_filtrados <- reactive({
    subset(valores$data_total, jugador == input$selector_jugador)
  })
  
  output$metrica_futbol <- renderUI({
    df <- datos_filtrados()
    req(nrow(df) > 0) # Asegura que haya datos seleccionados antes de renderizar
    tagList(
      p(strong("Probabilidad de Gol (Poisson):")),
      h3(paste0(round(df$goles_poisson * 100, 1), "%"), style = "color: #2c3e50; margin-bottom: 15px;"),
      p(strong("Pases Completados por Partido:")),
      h3(df$pases_normalizados, style = "color: #2c3e50;")
    )
  })
  
  output$metrica_psico <- renderUI({
    df <- datos_filtrados()
    req(nrow(df) > 0)
    tagList(
      p(strong("Puntaje de Resiliencia:")), h4(paste0(df$resiliencia_score, " / 100")),
      p(strong("Riesgo de Desarraigo:")), h4(df$riesgo_desarraigo, style = ifelse(df$riesgo_desarraigo == "Alto", "color: red;", "color: green;"))
    )
  })
  
  output$metrica_decision <- renderUI({
    df := datos_filtrados()
    req(nrow(df) > 0)
    
    prediccion <- "Monitorear"
    if (df$resiliencia_score < 40 || df$riesgo_desarraigo == "Alto") {
      prediccion <- "Descartar"
    } else if (df$resiliencia_score >= 80 && df$goles_poisson > 0.10) {
      prediccion <- "Fichar"
    }
    
    color_veredicto <- switch(prediccion, "Fichar" = "#27ae60", "Monitorear" = "#f39c12", "Descartar" = "#c0392b")
    tagList(p(strong("Recomendación:")), h2(prediccion, style = paste0("color: ", color_veredicto, "; font-weight: bold;")))
  })
  
  # CORRECCIÓN DE EXTENSIÓN: Descarga en HTML e imprime de forma nativa
  output$descargar_reporte <- downloadHandler(
    filename = function() {
      paste0("Ficha_Scouting_", input$selector_jugador, ".html")
    },
    content = function(file) {
      df <- datos_filtrados()
      
      prediccion <- "Monitorear"
      if (df$resiliencia_score < 40 || df$riesgo_desarraigo == "Alto") {
        prediccion <- "Descartar"
      } else if (df$resiliencia_score >= 80 && df$goles_poisson > 0.10) {
        prediccion <- "Fichar"
      }
      
      pdf_html <- paste0(
        "<html><head><title>Reporte Ejecutivo</title>",
        "<style>body { font-family: Arial, sans-serif; margin: 40px; color: #2c3e50; } ",
        "h1 { color: #2c3e50; border-bottom: 2px solid #ecf0f1; padding-bottom: 10px; } ",
        ".box { padding: 15px; background: #f8f9fa; border-left: 5px solid #3498db; margin-bottom: 15px; } ",
        ".decision { font-size: 24px; font-weight: bold; color: ", 
        ifelse(prediccion == "Fichar", "#27ae60", ifelse(prediccion == "Descartar", "#c0392b", "#f39c12")), "; }</style>",
        "<script>window.onload = function() { window.print(); }</script></head>",
        "<body>",
        "<h1>📋 Reporte Ejecutivo de Dirección Deportiva</h1>",
        "<h2>Candidato Evaluado: ", input$selector_jugador, "</h2>",
        "<hr>",
        "<div class='box'>",
        "<h3>1. Métricas Técnicas de Cancha</h3>",
        "<p><strong>Frecuencia de Gol (Poisson):</strong> ", round(df$goles_poisson * 100, 1), "%</p>",
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
      
      writeLines(pdf_html, file)
    }
  )
}

shinyApp(ui = ui, server = server)
