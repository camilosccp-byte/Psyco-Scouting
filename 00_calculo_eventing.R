# ---------------------------------------------------------
# Proyecto: Scouting Híbrido (Módulo 0: Cálculo de Eventing)
# Objetivo: Calcular Poisson/Bernoulli y exportar data a Excel
# ---------------------------------------------------------

# 1. Instalar librería para manejo de datos si no existe
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

# 2. Dataset crudo con el historial de rendimiento de los jugadores (Recuerda que en "data.frame" ingresas tu archivo previamente cargado
# 2.1 Tengamos en cuenta que estos datos han de haber sido ya limpiados y transformados por el analista, aqui, lo unico que hacemos es trabajarlos
# mediante las distribuciones para obtener sus probabilidaes, los estan *90 minutos
datos_crudos_scouting <- data.frame(
  jugador = c("Delantero A", "Mediocentro B", "Extremo C", "Central D", "Interior E"),
  promedio_goles_90min = c(0.55, 0.10, 0.40, 0.05, 0.20), # Usado como lambda para Poisson
  tasa_exito_regates   = c(0.70, 0.85, 0.60, 0.45, 0.75)  # Usado como prob para Bernoulli
)

# 3. Aplicamos los modelos estadísticos
datos_calculados <- datos_crudos_scouting %>%
  rowwise() %>%
  mutate(
    # POISSON: Probabilidad de que anote exactamente 1 gol en el próximo partido
    goles_poisson = round(dpois(x = 1, lambda = promedio_goles_90min), 2),
    
    # BERNOULLI: Probabilidad de éxito en su siguiente intento de regate (1 intento)
    regates_bernoulli = round(dbinom(x = 1, size = 1, prob = tasa_exito_regates), 2)
  ) %>%
  ungroup()

print("--- Métricas de Eventing Calculadas ---")
print(datos_calculados)

# 4. EXPORTAMOS A EXCEL: Generamos el archivo plano para tu computadora
# Al ejecutar esta línea en R, se creará un archivo que puedes abrir en Excel
write.csv(datos_calculados, "datos_prueba_scouting.csv", row.names = FALSE)
print("Archivo 'datos_prueba_scouting.csv' generado con éxito para usar en Excel.")
