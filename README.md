## 📊 Algoritmo de Scouting Híbrido: Rendimiento + Perfil Psicosocial

Este repositorio contiene la arquitectura de software aplicada y sencilla, apropiada para un sistema de **Scouting Inteligente de Fútbol Profesional** desarrollado en R. 

A diferencia de los modelos tradicionales de la industria que se limitan a analizar eventos con el balón, esta metodología pionera integra métricas de rendimiento en campo con variables del entorno psicométrico y conductual del atleta, en búsqueda de mitigar el riesgo financiero y deportivo en los fichajes.

---

## 🌐 Plataforma Interactiva en Producción (R Shiny)

El modelo cuenta con una aplicación web completamente funcional desplegada en la nube para uso de la junta directiva y el cuerpo técnico. 

👉 **[Acceder al Panel de Scouting en Vivo]( https://psyco-scouting-app.shinyapps.io/scouting_app/)** El analista que use el respositorio, debe buscar su usuario personal o del club, en ShinyApp

### Características del Panel Ejecutivo:
- **Simulación Reactiva:** Permite seleccionar candidatos del menú y recalcular instantáneamente sus indicadores técnicos y humanos.
- **Alimentación Dinámica Integrada (¡Nuevo!):** Ya no es necesario modificar los scripts de R para expandir el sistema. El analista o psicólogo puede cargar nuevos prospectos directamente desde la interfaz subiendo un archivo `.csv` o `.xlsx` (Excel). La app valida la estructura automáticamente y actualiza los desplegables en tiempo real.
- **Alertas Semafóricas:** Clasificación visual automática (Verde/Amarillo/Rojo) del nivel de riesgo psicosocial del futbolista.
- **Módulo de Exportación:** Incluye un botón automatizado para generar y descargar fichas técnicas completas en formato PDF ejecutivo (generando un archivo HTML auto-imprimible de forma nativa).

*Nota técnica:* Aunque la aplicación incluye una matriz base (`tibble`) de ejemplo para demostrar su funcionamiento en la prueba piloto, la suite está diseñada para ser alimentada a gran escala con los datasets y métricas específicas que el departamento de psicología deportiva y el cuerpo técnico del club decidan consensuar.

*⚠️ Nota sobre la Carga de Datos:* Para que el motor de alimentación en vivo integre tus archivos externos con éxito, tu documento (`.csv` o `.xlsx`) debe contener obligatoriamente las siguientes columnas en su primera fila (respetando minúsculas y guiones bajos): `jugador`, `goles_poisson`, `pases_normalizados`, `resiliencia_score` y `riesgo_desarraigo`. El sistema validará su formato automáticamente antes de refrescar el panel.
👉 **[Descargar Plantilla de Excel de Prueba (Click Aquí)](https://github.com)**


---

## 🚀 Innovación Metodológica: Variables Analizadas

El sistema evalúa la viabilidad del fichaje cruzando dos dimensiones críticas:

1. **Métricas de Cancha (Eventing Analytics):**
   - *Frecuencia de Gol (Distribución de Poisson):* Proyección analítica de efectividad ofensiva con base a datos históricos.
   - *Volumen de Juego:* Normalización y análisis de pases completados por cada 90 minutos de juego.
   
2. **Métricas Humanas y de Adaptación (Psicosocial Analytics):**
   - *Resiliencia Conductual:* Capacidad de respuesta y tolerancia ante escenarios de frustración y alta presión.
   - *Ecosistema de Desarraigo:* Evaluación predictiva de redes de contención geográfica necesarias para el éxito del atleta en un país extranjero (necesidad de un compañero de nacionalidad coadyuvante).
   - *Madurez Rol-Dependiente:* Impacto de variables socio-familiares (como la paternidad) para la asignación de posiciones tácticas de alta responsabilidad.

*Nota:* Las variables descritas en este prototipo son ilustrativas; el sistema permite sustituirlas o expandirlas según el criterio del psicólogo del club o los requerimientos de la posición a fichar.

---

## 🛠️ Arquitectura de Código del Repositorio

El flujo del proyecto está desacoplado en módulos estratégicos:

- **`00_calculo_eventing.R`:** Simulación del procesamiento inicial de datos crudos (*Eventing*) utilizando distribuciones de Poisson y Bernoulli, automatizando la exportación hacia archivos compatibles con Excel.
- **`01_imputacion_datos.R`:** Módulo de Inteligencia Artificial que soluciona el problema de los perfiles psicológicos vacíos en ligas lejanas mediante **Imputación por Bosques Aleatorios (`mice`)**, prediciendo variables conductuales con base en gemelos estadísticos en la cancha.
- **`02_arbol_decision.R`:** Árbol de clasificación lógica que procesa el pipeline completo y emite la recomendación definitiva del sistema: *Fichar, Monitorear o Descartar*.
- **`app.R`:** Código fuente de la interfaz gráfica y servidor web en **R Shiny** con motor de alimentación de datos en vivo y renderizado de reportes ejecutivos.

*   `ARGUMENTS.md` : Documento de fundamentación teórica que reúne el marco conceptual de la analítica conductual y el porqué de las variables seleccionadas, sirviendo de soporte para validar metodológicamente este proyecto.
*   `MEJORAS_FUTURAS.md` : Documento que detalla la hoja de ruta (*roadmap*) y las próximas optimizaciones del algoritmo. ¡Te invitamos a leerlo para conocer la evolución del proyecto!

---

## 📋 Requisitos e Instalación

Para clonar este repositorio y ejecutar la suite analítica completa o la aplicación localmente en RStudio, instale las dependencias requeridas ejecutando:

```R
install.packages(c("shiny", "shinythemes", "readxl", "mice", "rpart", "dplyr"))
```

### Ejecución de la app local:
Asegúrate de tener todos los archivos en el mismo directorio de trabajo y ejecuta en tu consola de RStudio:
```R
shiny::runApp()
```

---
*Desarrollado como una solución de Sports Analytics de Vanguardia para la Optimización del Mercado de Fichajes.*

