## Análisis Descriptivo :bike: City Bikes

## Temas

- :hammer_and_wrench: [Herramientas](#herramientas)
- </> [Lenguajes](#lenguajes)
- :gear: [Procesamiento y preparación de datos](#procesamiento-y-preparación-de-datos)
- :bar_chart: [Visualización y Análisis de Datos](/Visualizacion/README.md)
- :heavy_check_mark: [Conclusiones y Recomendaciones](/Presentacion/README.md)


## Objetivo

1. Calcular Métricas de Uso Diario:
   * Determinar el número promedio de viajes realizados en un día típico.
       * Calcular las estadísticas de duración de los viajes, incluyendo los valores máximos, mínimos, promedio y la desviación estándar.
2. Evaluar Métricas Históricas:
   * Calcular el total de viajes realizados en el programa de bicicletas compartidas.
3. Analizar el crecimiento del número de viajes diarios a lo largo del tiempo.
   * Desglosar el total de viajes según el género/edad o tipo de suscripción de los usuarios.
4. Derivar Conclusiones y Recomendaciones:
   * Identificar patrones y tendencias a partir de los datos analizados.
5. Ofrecer recomendaciones estratégicas basadas en los hallazgos para la nueva CEO.

   
## Procesamiento y preparación de datos

1. Conectar/importar datos a herramientas:

* Se creó el City-Bikes y el conjunto de datos Dataset en BigQuery.

* Tablas importadas: 

    * city_bike_trips.

2. Identificar y manejar valores nulos:

* Se identifican valores nulos a través del comando SQL COUNTIF.
* Se eliminaron los valores nulos para la edad .
* birth_year: 4796 nulos que representan el 9.59% del total de los registros, quedando 45204 registros en total.


3. Identificar y manejar valores duplicados:

* No se encontraron registros duplicados de viajes.

4. Identificar y manejar datos fuera del alcance del análisis:

* customer_plan: se excluyó la columna ya que no tenía información en ninguno de los registros, solo 50000 valores nulos.
* Se calculó la edad de los usuarios con EXTRACT(YEAR FROM CURRENT_DATE()) - birth_year) y se observó que habían  157 usuarios > 80 años , por la edad es posible que las fechas de nacimiento ingresadas no sean las correctas por lo cual se dejaron estos registros fuera del análisis.

5. Crear nuevas variables:

* trip_duration_minutos: Se creó la variable duración del viaje en minutos.
* stop_date: se cambió el tipo de datos de la variable stoptime a date para tener solo la fecha del viaje.

6. Unir tablas:

* Se creo una vista view_city_bike_trips , con las nuevas variables y excluyendo la que no era relevante para nuestro análisis.

Este proceso es fundamental para asegurar la calidad y precisión del análisis subsiguiente.

## Herramientas

* BigQuery
* Looker Studio
* Google Docs
* Google Slide

## Lenguajes

* SQL




