## ETL Superstore :department_store: :shopping_cart:

## Temas

- :hammer_and_wrench: [Herramientas](#herramientas)
- </> [Lenguajes](#lenguajes)
- :gear: [Procesamiento y preparación de datos](#procesamiento-y-preparación-de-datos)
- :memo: [Ficha Técnica y Documentación](/Ficha_Tecnica/README.md)
- :bar_chart: [Visualización y Análisis de Datos](/Visualizacion/README.md)
- :heavy_check_mark: [Conclusiones y Recomendaciones](/Presentacion/README.md)


## Objetivo

A través del proceso ETL(Extracción, Transformación y Carga), construir un sistema tabular para la tienda superstore que nos permita almacenar datos de manera eficiente y consultar estos datos más fácilmente.

   
## Procesamiento y preparación de datos

1. Conectar/importar datos a herramientas:

* Se creó el proyecto Superstore y el conjunto de datos Dataset en BigQuery.

* Tablas importadas: 

    - superstore.

2. Identificar y manejar valores nulos.

3. Identificar y manejar valores duplicados:

* No se encontraron registros duplicados.

4. Identificar y manejar datos discrepantes en variables categóricas.

5. Buscar datos de otras fuentes:

* Se hizo Web scraping, se utilizó Python para extraer los datos de la tabla “multinacional” de la página https://en.wikipedia.org/wiki/List_of_supermarket_chains, para incluir a los competidores en la estructura de datos de la empresa Super Store. Se eliminaron 59 registros  del archivo multinational.csv, que no tenían datos en las columnas de num_ empleado,  num_locat y  served_countries.

Para ver el diseño de la Estructura de la Base de datos revisar: [Ficha Técnica y Documentación](/Ficha_Tecnica/MER_Supestore.pdf)

## Herramientas

* BigQuery
* Looker Studio
* Google Docs
* Google Slide
* Google Colab

## Lenguajes

* SQL




