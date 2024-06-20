# Docker Swarm

orquesteador de docker

- permite crear un lcuster de uno o más nodos Dockers
- esto permite disponer de "servicios" que se despliegan de forma replicada a lo largo de los nodos del cluster
- su aruqitectura cuenta de manager y workers

- Servicios en swarm
    - cuando desplegamos una imagne en el docker engine se crea un servicio
    - un servicio identifica tareas en el contexto de una aplicacion, por ejemplo un servidor web, un base de datsao, etc
    - siempre debemos indicar la imagen a usar para crear los contenedores y que comandos lanzar dentro

## Crear un cluster Swarm

- crear nodo manager

docker swarm init --advertise-addr <ip>

### add worker to this swarm
```
docker swarm join --token <TOKEN> <ip>
```


docker info

docker node ls lista nodo the swarm

para sacar el token para adiccionar un worker

docker swarm join-token worker

para adicionar manager

docker swarm join-token manager

### add managers

- docker swarm join-token manager
- docker swarm join --token <TOKEN> <ip>

to porvide fault tolerance the node manager need to be odd

N manager  (n-1/2)
3           1
5           2
7           3
9           4
11          5

###

### promoveer o degradar nodos

docker node demote <ID or HOSTNAME>

demote      Demote one or more nodes from manager in the swarm

promote     Promote one or more nodes to manager in the swarm

## Servicios y tareas en docker swarm

- se usan para desplegar aplicaciones
- normalmnete un servicio es en realidad un micro servicio es decir un componente individual que pertenece a una aplicacion mas grande:
- por ejemplo podemos considerar un servicio a un servidor web, una base de datos o cualquier otro componente de mi aplicacion que este ofreciendo algun recurso al resto
- Cuando creó un servicio debo de indicar una serie de caracteristicas asociadas al mismo:
    - numeor de replicas del servicio que se van a ejecutar
    - configuracion de CPU de memoria
    - un posible red de tipo overlay
    - puerto por el que vamos a poder acceder al servicio

### Tarea

- cuando se crea un servicio en realidad lo que se hace es lanzar una o varias tareas de tipo replica en los nodos
- las tareas se ejecutan de manera completamente indepenidente unas de otras

### tipos de servicios

replicados y globales

replicados se distribuyen en los nodos necesarios

globales ejecuta una tarea en cada nodo del cluster

Servicios replicados: se trata de tareas que se ejecutan en un número de réplicas definido por el usuario. A su vez, cada réplica es una instancia del contenedor definido en el servicio. Los servicios replicados se pueden escalar, permitiendo a los usuarios crear réplicas adicionales. Si así se requiere, un servidor web como NGINX se puede escalar en 2, 4 o 100 instancias con una sola línea de comandos.

Servicios globales: si un servicio se ejecuta en modo global, cada nodo disponible en el clúster inicia una tarea para el servicio correspondiente. Si al clúster se le añade un nodo nuevo, el maestro de Swarm le atribuye una tarea para el servicio global de forma inmediata. Este tipo de servicios se recomienda para las aplicaciones de monitoreo o los programas antivirus.

## Crear servicio

docker service create --name apache httpd

docker service ls # mirar los servicios
docker service ps <nombre servicio> # ver donde esta funcionando la imagen
docker service inspect <nombre servicio> # informacion del servicio

## Acceder a un servicio

docker service create --name <nombre servicio> --publish published=nodo puerto, target=puerto contendedor <image>

# red Overlay

- docker _gwbridge driver tipo bridge scope swarm # comunica los daemon entre si de las maquinas del cluster
- ingress tipo overlay scope swarm


# replicas servicios

```
docker service create --name web3 -p 8003:80 --replicas=3 httpd
```

# Scale 

docker service scale web1=5

