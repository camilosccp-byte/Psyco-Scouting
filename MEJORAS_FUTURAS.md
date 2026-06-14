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

### 4. Telemetría Psicofisiológica en Situaciones de Alta Tensión (Algoritmo Spatial-Stress)
- **Objetivo:** Cuantificar la resiliencia mental, la ansiedad y el foco neurocognitivo del jugador en momentos críticos del partido.
- **Fundamento:** Se integrarán datos biométricos en tiempo real provenientes de los chalecos GPS (Frecuencia Cardíaca, Variabilidad de la Frecuencia Cardíaca - VFC y Ritmo Respiratorio). Mediante algoritmos de geocercas espaciales, el sistema identificará cuándo el jugador entra en zonas de alta presión (como el área penal o un mano a mano con el arquero). Al cruzar los datos, el modelo aislará el esfuerzo físico del desgaste emocional: si las pulsaciones y la frecuencia respiratoria se disparan mientras la velocidad del jugador es baja o nula, el sistema detectará un estado de estrés psicológico (pánico o bloqueo). Por el contrario, exhalaciones profundas y una VFC estable indicarán un estado de relajación y concentración óptima, ofreciendo un indicador clave sobre cómo reacciona la mente del atleta bajo presión.

Esto será útil en un futuro, tambien para comprobar que el entrenamiento pre partido (o en entrenamiento) con coaching de técnicas de relajacion (mindfullness - yoga aplicada), son claves para lograr que el jugador este concentrado. Se integrará telemetría de wearables para medir la VFC y el ritmo respiratorio dentro de geocercas en el área penal ( o zonas de posibles perdidas o duelos que dejen expuesto al equipo: en general situaciones de alta tension psicológica), permitiendo cuantificar la resiliencia mental y ansiedad del jugador ante escenarios de alta tensión. El algoritmo Spatial-Stress correlacionará picos fisiológicos no mecánicos para identificar estados de pánico o foco neurocognitivo óptimo.

---
*Este roadmap consolida la transformación del scouting deportivo en una herramienta de gestión de activos financieros de alta precisión.*
