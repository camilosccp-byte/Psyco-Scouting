# ---------------------------------------------------------
# Proyecto: Scouting Híbrido (Módulo 2: Árbol de Decisión)
# Objetivo: Clasificar viabilidad de fichaje integrando psicología
# ---------------------------------------------------------

# Cargar librerías de modelado visual
if(!require(rpart)) install.packages("rpart")
if(!require(rpart.plot)) install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

# 1. Base de datos completa (Incluímos la columna de decisión histórica)
# Recordemos que como analista puedes agegar las metricas que desees!

# NOTA PARA EL USUARIO: Este dataset de entrenamiento es un ejemplo simulado. 
# En la práctica, debe modificarse obligatoriamente según el historial de fichajes 
# pasados del club, su presupuesto y la filosofía de juego/táctica del cuerpo técnico.
dataset_entrenamiento <- data.frame(
  goles_poisson     = c(0.42, 0.12, 0.35, 0.05, 0.18, 0.50, 0.10, 0.30),
  resiliencia_score = c(85, 90, 30, 45, 70, 40, 88, 92),
  riesgo_desarraigo = c("Bajo", "Bajo", "Alto", "Alto", "Medio", "Alto", "Bajo", "Bajo"),
  es_padre          = c(1, 1, 0, 0, 0, 1, 0, 1),
  decision_final    = c("Fichar", "Fichar", "Descartar", "Descartar", "Monitorear", "Descartar", "Monitorear", "Fichar")
)

# 2. Entrenamos el árbol de decisión híbrido
modelo_scouting <- rpart(decision_final ~ goles_poisson + resiliencia_score + riesgo_desarraigo + es_padre, 
                         data = dataset_entrenamiento, 
                         method = "class")

# 3. Generamos el gráfico exportable para presentaciones
rpart.plot(modelo_scouting, type = 2, extra = 104, main = "Filtro Híbrido: Rendimiento + Perfil Humano")
