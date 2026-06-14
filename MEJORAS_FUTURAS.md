# 📈 RoadMap de Innovación: Proyección de Valor de Mercado

Para las próximas versiones del sistema de **Scouting Híbrido**, el ecosistema analítico se expandirá hacia la dimensión financiera, permitiendo predecir la viabilidad económica del fichaje y su retorno de inversión (ROI).

## 🚀 Próximas Implementaciones Estadísticas

### 1. Modelado del Valor Actual (Distribución Lognormal)
- **Objetivo:** Simular escenarios de cotización económica del jugador.
- **Fundamento:** Dado que el valor de mercado de los futbolistas no puede ser negativo y presenta un sesgo masivo hacia la derecha (pocos jugadores concentran los valores élite), se implementará la **Distribución Lognormal** mediante la función `dlnorm()` en R para calcular la probabilidad de que un atleta alcance ciertos umbrales de precio.

### 2. Proyección de Precios en el Tiempo (Movimiento Browniano Geométrico)
- **Objetivo:** Predecir cuánto valdrá el jugador en los próximos 3 años para calcular el valor de reventa.
- **Fundamento:** Utilizando ecuaciones diferenciales estocásticas, el modelo combinará:
  - *Drift (Tendencia):* El crecimiento esperado del valor según la edad (curva de madurez del futbolista) y su rendimiento en la cancha.
  - *Volatility (Incertidumbre):* El riesgo de mercado (inflación de fichajes, historial de lesiones y variables psicosociales).

### 3. Machine Learning Predictivo (Regresiones Avanzadas)
- **Objetivo:** Tasar de forma automatizada a jugadores de ligas secundarias.
- **Fundamento:** Modelos de regresión (XGBoost / Random Forest) que cruzarán las métricas de *Eventing* con los indicadores humanos para identificar "jugadores infravalorados" antes de que explote su precio de mercado, asumiendo una distribución normal en los errores de estimación.

---
*Este roadmap consolida la transformación del scouting deportivo en una herramienta de gestión de activos financieros de alta precisión.*
