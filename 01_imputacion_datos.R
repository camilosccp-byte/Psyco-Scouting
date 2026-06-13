# ---------------------------------------------------------
# Proyecto: Scouting Híbrido (Módulo 1: Imputación Psicosocial)
# Objetivo: Rellenar perfiles psicológicos vacíos usando MICE
# ---------------------------------------------------------

# Cargamos librería para imputación bayesiana
if(!require(mice)) install.packages("mice")
library(mice)

# 1. Creamos base de datos simulada con registros incompletos (NA)
# Nota para el analista: Tanto variables de eventing, como en variables psicosociales puedes agregar las que desees!
base_scouting <- data.frame(
  jugador           = c("Delantero A", "Mediocentro B", "Extremo C", "Central D", "Interior E"),
  goles_poisson     = c(0.42, 0.12, 0.35, 0.05, 0.18),
  pases_normalizados = c(22, 58, 31, 45, 40),
  
  # Variables Psicosociales Innovadoras (Algunas faltantes por falta de acceso inicial)
  es_padre          = c(1, 1, 0, NA, 0),        # 1 = Sí, 0 = No
  resiliencia_score = c(85, 90, NA, 45, 70),    # Escala 1-100
  riesgo_desarraigo = c("Bajo", "Bajo", "Alto", NA, "Medio")
)

print("--- Datos Originales con Vacíos (NA) ---")
print(base_scouting)

# 2. Ejecutamos la imputación predictiva y así completamos el perfil del jugador
set.seed(123)
datos_predichos <- mice(base_scouting, method = 'rf', m = 1, printFlag = FALSE)
datos_completos  <- complete(datos_predichos)

print("--- Datos Completados mediante Imputación ---")
print(datos_completos)
