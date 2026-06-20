## 📊 Algoritmo de Scouting Híbrido: Rendimiento + Perfil Psicosocial

Este repositorio contiene la arquitectura de software avanzada para un sistema de **Scouting Inteligente de Fútbol Profesional** desarrollado en R. 

A diferencia de los modelos tradicionales de la industria que se limitan a analizar eventos con el balón, esta metodología pionera integra y agrega métricas de rendimiento en campo con variables del entorno psicométrico y conductual del atleta para mitigar el riesgo financiero y deportivo en los fichajes.

---

🌐 Plataforma Interactiva en Producción (R Shiny)

El modelo cuenta con una aplicación web completamente funcional desplegada en la nube para uso de la junta directiva y el cuerpo técnico. 

👉 **[Acceder al Panel de Scouting en Vivo](https://mi-analisis-premier.shinyapps.io/scouting_app/)** 

Características del Panel Ejecutivo:
- **Simulación Reactiva:** Permite seleccionar candidatos del menú y recalcular instantáneamente sus indicadores técnicos y humanos.
- **Alertas Semafóricas:** Clasificación visual automática (Verde/Amarillo/Rojo) del nivel de riesgo psicosocial del futbolista.
- **Módulo de Exportación:** Incluye un botón automatizado para generar y descargar fichas técnicas completas en formato PDF ejecutivo de forma nativa.
- Tener en cuenta que se debe copiar y usar este codigo por el propio analista, sabiendo como crear o usar un usuario en Shiny. El mismo puede agregar su data set, previamente limpiado y transformado, del cual debe extraer o crear sus metricas de intéres tanto de tipo táctico como psicológico consensuadas con el cuerpo técnico. La aplicacion como se menciona es una prueba piloto, para la cual en el archivo de eventing se creo un pequeño tibble (matriz) para ver su funcionamiento, pero esto podría ser ampliado como se menciona con el data set proveido por el club y las metricas elegidas por el departamento de psicología deportiva

---

🚀 Innovación Metodológica: Variables Analizadas

El sistema evalúa la viabilidad del fichaje cruzando dos dimensiones críticas:

1. **Métricas de Cancha (Eventing Analytics):**
   - *Frecuencia de Gol (Distribución de Poisson):* Proyección analítica de efectividad ofensiva en base a datos históricos.
   - *Volumen de Juego:* Normalización y análisis de pases completados por cada 90 minutos de juego.
   - **Tener en cuenta que los datos son usados base de ejemplo, por lo tanto, quien guste usarlo, debe usar su propio data set y deciri que otros datos de eventing va a usar y agregar

2. **Métricas Humanas y de Adaptación (Psicosocial Analytics):**
   - *Resiliencia Conductual:* Capacidad de respuesta y tolerancia ante escenarios de frustración y alta presión.
   - *Ecosistema de Desarraigo:* Evaluación predictiva de redes de contención geográfica necesarias para el éxito del atleta en un país extranjero (necesidad de un compañero de nacionalidad coadyuvante).
   - *Madurez Rol-Dependiente:* Impacto de variables socio-familiares (como la paternidad) para la asignación de posiciones tácticas de alta responsabilidad.
   - Las métricas aquí descritas pueden ser usadas o cambiadas según su criterio y según la posicion, ademas de lo que considere el psicologo sobre el perfil que buscan fichar

---

🛠️ Arquitectura de Código del Repositorio

El flujo del proyecto está desacoplado en módulos estratégicos:

- **`00_calculo_eventing.R`:** Simulación del procesamiento inicial de datos crudos (*Eventing*) utilizando distribuciones de Poisson y Bernoulli, automatizando la exportación hacia bases de datos compatibles con Excel (`.csv`).
- **`01_imputacion_datos.R`:** Módulo de Inteligencia Artificial que soluciona el problema de los perfiles psicológicos vacíos en ligas lejanas mediante **Imputación por Bosques Aleatorios (`mice`)**, prediciendo variables conductuales en base a gemelos estadísticos en la cancha.
- **`02_arbol_decision.R`:** Árbol de clasificación lógica que procesa el pipeline completo y emite la recomendación definitiva del sistema: *Fichar, Monitorear o Descartar*.
- **`app.R`:** Código fuente de la interfaz gráfica y servidor web en **R Shiny** con motor de renderizado PDF integrado (`pagedown`).
- Tener en cuenta que el codigo puede ser mejorado para agregar mas sliders, controladores o visualizaciones según métricas que se hayan elegida en la transformación

---

📋 Requisitos e Instalación

Para clonar este repositorio y ejecutar la suite analítica completa o la aplicación localmente en RStudio, instale las dependencias requeridas ejecutando:

```R
install.packages(c("shiny", "shinythemes", "pagedown", "mice", "rpart", "dplyr"))
```

Ejecución de la app local:
```R
shiny::runApp()
```

---
*Desarrollado como una solución de Sports Analytics de Vanguardia para la Optimización del Mercado de Fichajes.*


