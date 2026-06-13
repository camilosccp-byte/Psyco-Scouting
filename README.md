# Algoritmo de Scouting Híbrido Basado en Modelos Psicosociales

Este repositorio contiene la arquitectura base para implementar un sistema de **Scouting de Fútbol Avanzado**. A diferencia de los modelos tradicionales, esta metodología integra variables estadísticas de rendimiento en cancha con perfiles psicométricos y conductuales del jugador.

## 🚀 Innovación del Modelo
El sistema evalúa el riesgo de fichaje analizando:
- **Resiliencia Lingüística:** Capacidad de respuesta ante la frustración.
- **Ecosistema de Desarraigo:** Redes de contención geográfica necesarias para el éxito del atleta.
- **Madurez Rol-Dependiente:** Impacto de variables socio-familiares (como la paternidad) en posiciones tácticas de alta responsabilidad.

## 🛠️ Estructura del Código
1. `01_imputacion_datos.R`: Manejo de datos faltantes (NA) en perfiles psicológicos mediante Imputación por Bosques Aleatorios (`mice`).
2. `02_arbol_decision.R`: Clasificación predictiva y toma de decisiones automatizada (`rpart`) cruzando fútbol y psicología.

## 📋 Requisitos
Para ejecutar estos scripts en R, necesitas instalar:
```R
install.packages(c("mice", "rpart", "rpart.plot"))
```


