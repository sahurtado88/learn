

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


