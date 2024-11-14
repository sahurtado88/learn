# Kinesis Data Firehose
- Fully Managed Service, no administration, automatic scaling, serverless
    - AWS: Redshift / Amazon S3 / OpenSearch
    - 3rd party partner: Splunk / MongoDB / DataDog / NewRelic / …
    - Custom: send to any HTTP endpoint
- Pay for data going through Firehose
- Near Real Time
    - Buffer interval: 0 seconds (no buffering) to 900 seconds
    - Buffer size: minimum 1MB
- Supports many data formats, conversions, transformations, compression
- Supports custom data transformations using AWS Lambda
- Can send failed or all data to a backup S3 bucket



## Buffer size
The higher buffer size may be lower in cost with higher latency. The lower buffer size will be faster in delivery with higher cost and less latency

## Buffer interval
The higher interval allows more time to collect data and the size of data may be bigger. the lower interval sends the data more frequently and may be more advantageous when looking at shorter cycles of data activity

Kinesis data firehouse entregara los datos cuando:
- el tamaño del buffer acumulado alcance el valor configurado en el buffer size o
- se alcance el tiempo definido en el buffer interval

la entrega se hara cuando cualquiera de estos dos eventos ocurra. Esto permite un balance entre latencia de entrega y costo de transacciones

Ejemplos

- flujo constante y alto volumen de datos: buffer size alto y un buffer interval bajo para asegurarte que los datos se entreguen de manera eficiente
- flujo intermitente o bajo volumne de datos: buffer interval alto para que los datos se acumulen en el buffer y se envien en lotes, reduciendo asi el numero de transacciones

# ejemplos con diferentes combinacion de buffer interval y buffer size

## bufer size bajo y buffer interval bajo
buffer size 1 MB y buffer interval 60 segundos
este escenario es util para aplicaciones de streaming en tiempo real donde los datos deben entregarse rapidamente, auqneu sean en volumenes pequeños, ideal para aplicaciones con menor latencia posible
los datos se envian en lotes pequeños y con alta frecuencia, lo cual incrementa la cantidad de entregas y por lo tnaot el costo

## Buffer size alto y buffer interval bajo

Ejemplo: Buffer size de 64 MB y buffer interval de 60 segundos.
Escenario: Ideal para flujos de datos de alto volumen y baja latencia, en los que se generan grandes cantidades de datos en periodos cortos.
Uso: Es útil para aplicaciones que necesitan grandes volúmenes de datos entregados rápidamente, como la ingesta de datos de eventos de aplicaciones móviles o de redes sociales en tiempo real.
Resultado: El buffer probablemente se llenará antes de alcanzar el intervalo de tiempo, y los datos se enviarán en lotes grandes y frecuentes, optimizando la eficiencia de las transacciones.

## Buffer size bajo y buffer interval alto

Ejemplo: Buffer size de 1 MB y buffer interval de 300 segundos.
Escenario: Este escenario es útil para aplicaciones que generan pocos datos o datos esporádicos y no necesitan una entrega inmediata.
Uso: Funciona bien para aplicaciones de análisis que pueden recibir los datos en lotes pequeños y de manera ocasional, como la recolección de logs de baja frecuencia.
Resultado: Los datos se envían cada vez que se llena el buffer de 1 MB o al cumplirse el intervalo de 300 segundos, minimizando el costo y permitiendo una entrega menos frecuente.

## Buffer size alto y buffer interval alto

Ejemplo: Buffer size de 128 MB y buffer interval de 900 segundos (15 minutos).
Escenario: Este escenario es ideal para flujos de datos de alto volumen en aplicaciones que no requieren recibir los datos rápidamente, sino en grandes bloques para procesarlos en lotes.
Uso: Muy adecuado para cargas de trabajo que requieren análisis en diferido o procesamiento por lotes, como el análisis de registros históricos o almacenamiento de grandes volúmenes de datos en un data lake.
Resultado: Los datos se acumulan durante más tiempo y en grandes cantidades, resultando en menos entregas de datos al destino y optimizando costos.

## Resumen
|Configuración|	Buffer size	| Buffer interval|	Descripción|
|-|-|-|-|
Bajo tamaño y bajo intervalo	|1 MB	|60 s |	Alta frecuencia, entrega rápida, útil para datos en tiempo real, aunque aumenta el costo de envío.
Alto tamaño y bajo intervalo|	64 MB	|60 s	|Entrega rápida en grandes volúmenes; buena para datos de alto volumen y baja latencia.
Bajo tamaño y alto intervalo|	1 MB	|300 s	|Para datos esporádicos con baja latencia, entrega en pequeños lotes ocasionales.
Alto tamaño y alto intervalo|	128 MB	|900 s	|Entrega en grandes lotes en intervalos largos; ideal para procesamiento en lotes y reducción de costos.


# Amazon Kinesis Data Firehose

 is a fully managed service for delivering real-time streaming data to destinations such as Amazon Simple Storage Service (Amazon S3), Amazon Redshift, Amazon OpenSearch Service, Splunk, and any custom HTTP endpoint or HTTP endpoints owned by supported third-party service providers, including Datadog, Dynatrace, LogicMonitor, MongoDB, New Relic, and Sumo Logic.

Firehose cannot directly write into a DynamoDB table, so this option is incorrect.