# Docker Compose

Docker Compose is a tool for defining and running multi-container applications. It is the key to unlocking a streamlined and efficient development and deployment experience.

```
version: 2
services:
    redis:
    image: redis
    db:
    image: postgres:9.4
    vote:
    image: voting-app
    ports:
        - 5000:80
    depends_on:
      - redis    
    result:
    image: result
    ports:
        - 5001:80
    worker:
    image: worker

```

```
version: 2
services:
    redis:
    image: redis
    db:
    image: postgres:9.4
    vote:
    build: ./vote
    ports:
        - 5000:80
    depends_on:
      - redis

    result:
    build: ./result
    ports:
        - 5001:80

    worker:
    build: ./worker

```

```
version: 3
services:
    redis:
    image: redis
    db:
    image: postgres:9.4
    vote:
    build: ./vote
    ports:
        - 5000:80
    depends_on:
      - redis

    result:
    build: ./result
    ports:
        - 5001:80

    worker:
    build: ./worker

```

```
version: 2
services:
    redis:
        image: redis
        networks:
            -back-end

    db:
        image: postgres:9.4
        networks:
            - back-end


    vote:
        build: ./vote
        ports:
            - 5000:80
        depends_on:
        - redis
        netwroks:
            - front-end
            - back-end

    result:
        build: ./result
        ports:
            - 5001:80
        netwroks:
            - front-end
            - back-end

    worker:
        build: ./worker

networks:
  front-end:
  back-end:

```

# docker sambple vote app

```
version: "3"

services:
  vote:
    build: ./vote
    command: python app.py
    volumes:
     - ./vote:/app
    ports:
      - "5000:80"
    networks:
      - front-tier
      - back-tier

  result:
    build: ./result
    command: nodemon --debug server.js
    volumes:
      - ./result:/app
    ports:
      - "5001:80"
      - "5858:5858"
    networks:
      - front-tier
      - back-tier

  worker:
    build:
      context: ./worker
    networks:
      - back-tier

  redis:
    image: redis:alpine
    container_name: redis
    ports: ["6379"]
    networks:
      - back-tier

  db:
    image: postgres:9.4
    environment:
      POSGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
    container_name: db
    volumes:
      - "db-data:/var/lib/postgresql/data"
    networks:
      - back-tier

volumes:
  db-data:

networks:
  front-tier:
  back-tier:
```

# Docker Swarm

docker recommneds 7 managers

quorum of N = (n/2)+1

ex: (5/2)+1= 3.5 =3

fault tolerance of N = (n/2)-1

odd number of masters nodes

Manager 1 Quorum 1 Fault tolerance 0
Manager 2 Quorum 2 Fault tolerance 0
Manager 3 Quorum 2 Fault tolerance 1 
Manager 4 Quorum 3 Fault tolerance 1
Manager 5 Quorum 3 Fault tolerance 2
Manager 6 Quorum 4 Fault tolerance 2
Manager 7 Quorum 4 Fault tolerance 3


docker swarm init --fprce-new-cluster

use only a node as Manager use the next command:
```
docker nodse update --availability drain <Node>
```

este comnado activa el cluster
docker swarm init

abandonar el clsuter se usa

```
docker swarm leave
```