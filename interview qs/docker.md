# Docker
Docker, or Docker Engine, is a popular open-source container runtime that allows software developers to build, deploy, and test containerized applications on various platforms. Docker containers are self-contained packages of applications and related files that are created with the Docker framework.

# 1. Can you tell something about docker container?

In simplest terms, docker containers consist of applications and all their dependencies.
They share the kernel and system resources with other containers and run as isolated systems in the host operating system.
The main aim of docker containers is to get rid of the infrastructure dependency while deploying and running applications. This means that any containerized application can run on any platform irrespective of the infrastructure being used beneath.
Technically, they are just the runtime instances of docker images.

# 2. What is the difference between an Image, Container, and Engine?

- An image in Docker is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

- A container is a running instance of an image. It is a lightweight, standalone, and executable software package that includes everything needed to run the software in an isolated environment.

- A Docker engine is a background service that manages and runs Docker containers. It is responsible for creating, starting, stopping, and deleting containers, as well as managing their networking and storage. The Docker engine is the underlying technology that runs and manages the containers.

# 3. What is a DockerFile?

It is a text file that has all commands which need to be run for building a given image.

# 4. Can you tell what is the functionality of a hypervisor?

A hypervisor is a software that makes virtualization happen because of which is sometimes referred to as the Virtual Machine Monitor. This divides the resources of the host system and allocates them to each guest environment installed.

# 5. What can you tell about Docker Compose?

It is a YAML file consisting of all the details regarding various services, networks, and volumes that are needed for setting up the Docker-based application. So, docker-compose is used for creating multiple containers, host them and establish communication between them. For the purpose of communication amongst the containers, ports are exposed by each and every container.

# 6.  Can you tell something about docker namespace?

A namespace is basically a Linux feature that ensures OS resources partition in a mutually exclusive manner. This forms the core concept behind containerization as namespaces introduce a layer of isolation amongst the containers. In docker, the namespaces ensure that the containers are portable and they don't affect the underlying host. Examples for namespace types that are currently being supported by Docker – PID, Mount, User, Network, IPC.

# 7. What is the docker command that lists the status of all docker containers?

In order to get the status of all the containers, we run the below command: docker ps -a

# 8. On what circumstances will you lose data stored in a container?

The data of a container remains in it until and unless you delete the container.

# 9. What is docker image registry?

A Docker image registry, in simple terms, is an area where the docker images are stored. Instead of converting the applications to containers each and every time, a developer can directly use the images stored in the registry.
This image registry can either be public or private and Docker hub is the most popular and famous public registry available.

# Docker components

There are three docker components, they are - Docker Client, Docker Host, and Docker Registry.

- Docker Client: This component performs “build” and “run” operations for the purpose of opening communication with the docker host.
- Docker Host: This component has the main docker daemon and hosts containers and their associated images. The daemon establishes a connection with the docker registry.
- Docker Registry: This component stores the docker images. There can be a public registry or a private one. The most famous public registries are Docker Hub and Docker Cloud.

# 11. What is a Docker Hub?

It is a public cloud-based registry provided by Docker for storing public images of the containers along with the provision of finding and sharing them.
The images can be pushed to Docker Hub through the docker push command.

# 12. What command can you run to export a docker image as an archive?

This can be done using the docker save command and the syntax is: docker save -o <exported_name>.tar <container-name>

# 13. What command can be run to import a pre-exported Docker image into another Docker host?

This can be done using the docker load command and the syntax is docker load -i <export_image_name>.tar

# 14. Can a paused container be removed from Docker?

No, it is not possible! A container MUST be in the stopped state before we can remove it.

# 15. What command is used to check for the version of docker client and server?

The command used to get all version information of the client and server is the docker version.
To get only the server version details, we can run docker version --format '{{.Server.Version}}'

# 16. Differentiate between virtualization and containerization.

Virtualization 	
- This helps developers to run and host multiple OS on the hardware of a single physical server.
- Hypervisors provide overall virtual machines to the guest operating systems.
- These virtual machines form an abstraction of the system hardware layer this means that each virtual machine on the host acts like a physical machine.

Containerization

- This helps developers to deploy multiple applications using the same operating system on a single virtual machine or server.
- Containers ensure isolated environment/ user spaces are provided for running the applications. Any changes done within the container do not reflect on the host or other containers of the same host.
- Containers form abstraction of the application layer which means that each container constitutes a different application.

# Can a container restart by itself?
Yes, it is possible only while using certain docker-defined policies while using the docker run command. Following are the available policies:

    1. Off: In this, the container won’t be restarted in case it's stopped or it fails.
    2. On-failure: Here, the container restarts by itself only when it experiences failures not associated with the user.
    3. Unless-stopped: Using this policy, ensures that a container can restart only when the command is executed to stop it by the user.
    4. Always: Irrespective of the failure or stopping, the container always gets restarted in this type of policy.

These policies can be used as:
docker run -dit — restart [restart-policy-value] [container_name]

# docker Image vs  Layer

Image: This is built up from a series of read-only layers of instructions. An image corresponds to the docker container and is used for speedy operation due to the caching mechanism of each step.

Layer: Each layer corresponds to an instruction of the image’s Dockerfile. In simple words, the layer is also an image but it is the image of the instructions run.

- The result of building this docker file is an image. Whereas the instructions present in this file add the layers to the image. The layers can be thought of as intermediate images.

6. Where are docker volumes stored in docker?

Volumes are created and managed by Docker and cannot be accessed by non-docker entities. They are stored in Docker host filesystem at /var/lib/docker/volumes/

7. What does the docker info command do?

The command gets detailed information about Docker installed on the host system. The information can be like what is the number of containers or images and in what state they are running and hardware specifications like total memory allocated, speed of the processor, kernel version, etc.

8. Can you tell the what are the purposes of up, run, and start commands of docker compose?

Using the up command for keeping a docker-compose up (ideally at all times), we can start or restart all the networks, services, and drivers associated with the app that are specified in the docker-compose.yml file. Now if we are running the docker-compose up in the “attached” mode then all the logs from the containers would be accessible to us. In case the docker-compose is run in the “detached” mode, then once the containers are started, it just exits and shows no logs.
Using the run command, the docker-compose can run one-off or ad-hoc tasks based on the business requirements. Here, the service name has to be provided and the docker starts only that specific service and also the other services to which the target service is dependent (if any).
- This command is helpful for testing the containers and also performing tasks such as adding or removing data to the container volumes etc.
Using the start command, only those containers can be restarted which were already created and then stopped. This is not useful for creating new containers on its own.

# 10. Can you tell the approach to login to the docker registry?

Using the docker login command credentials to log in to their own cloud repositories can be entered and accessed.

11. List the most commonly used instructions in Dockerfile?

- FROM: This is used to set the base image for upcoming instructions. A docker file is considered to be valid if it starts with the FROM instruction.
- LABEL: This is used for the image organization based on projects, modules, or licensing. It also helps in automation as we specify a key-value pair while defining a label that can be later accessed and handled programmatically.
- RUN: This command is used to execute instructions following it on the top of the current image in a new layer. Note that with each RUN command execution, we add layers on top of the image and then use that in subsequent steps.
- CMD: This command is used to provide default values of an executing container. In cases of multiple CMD commands the last instruction would be considered.

12. Can you differentiate between Daemon Logging and Container Logging?

In docker, logging is supported at 2 levels and they are logging at the Daemon level or logging at the Container level.

- Daemon Level: This kind of logging has four levels- Debug, Info, Error, and Fatal.
    - Debug has all the data that happened during the execution of the daemon process.
    - Info carries all the information along with the error information during the execution of the daemon process.
    - Errors have those errors that occurred during the execution of the daemon process.
    - Fatal has the fatal errors that occurred during the execution.
Container Level:
    - Container level logging can be done using the command: sudo docker run –it <container_name> /bin/bash
    - In order to check for the container level logs, we can run the command: sudo docker logs <container_id>
    13. What is the way to establish communication between docker host and Linux host?
    This can be done using networking by identifying the “ipconfig” on the docker host. This command ensures that an ethernet adapter is created as long as the docker is present in the host.

14. What is the best way of deleting a container?
We need to follow the following two steps for deleting a container:
- docker stop <container_id>
- docker rm <container_id>

15. Can you tell the difference between CMD and ENTRYPOINT?

CMD command provides executable defaults for an executing container. In case the executable has to be omitted then the usage of ENTRYPOINT instruction along with the JSON array format has to be incorporated.
ENTRYPOINT specifies that the instruction within it will always be run when the container starts. 
This command provides an option to configure the parameters and the executables. If the DockerFile does not have this command, then it would still get inherited from the base image mentioned in the FROM instruction.
- The most commonly used ENTRYPOINT is /bin/sh or /bin/bash for most of the base images.
As part of good practices, every DockerFile should have at least one of these two commands.

2. How many containers you can run in docker and what are the factors influencing this limit?

There is no clearly defined limit to the number of containers that can be run within docker. But it all depends on the limitations - more specifically hardware restrictions. The size of the app and the CPU resources available are 2 important factors influencing this limit. In case your application is not very big and you have abundant CPU resources, then we can run a huge number of containers.

3. Describe the lifecycle of Docker Container?

The different stages of the docker container from the start of creating it to its end are called the docker container life cycle. 
The most important stages are:

- Created: This is the state where the container has just been created new but not started yet.
- Running: In this state, the container would be running with all its associated processes.
- Paused: This state happens when the running container has been paused.
- Stopped: This state happens when the running container has been stopped.
- Deleted: In this, the container is in a dead state.

![alt text](image-24.png)



### run and cmd

The CMD and RUN commands in Docker are used to specify commands that should be executed when a container is started from a given image.

The CMD command, is used to specify the default command that should be executed when a container is started from an image. This command can be overridden when starting a container, which means that it does not have to be executed every time a container is started.

The RUN command, on the other hand, is used to execute a command during the image-building process. It will run command(s) in a new layer on top of the current image and commit the results. The command(s) in a RUN instruction will always be executed when the image is being built.

### ADD and COPY

Both the commands have similar functionality, but COPY is more preferred because of its higher transparency level than that of ADD.
COPY provides just the basic support of copying local files into the container whereas ADD provides additional features like remote URL and tar extraction support.


### CMD and entrypoint
Because CMD and ENTRYPOINT work in tandem, they can often be confusing to understand. However, they have different effects and exist to increase your image’s flexibility: ENTRYPOINT sets the process to run, while CMD supplies default arguments to that process.

The ENTRYPOINT Dockerfile instruction sets the process that’s executed when your container starts.

ENTRYPOINT is the process that’s executed inside the container.
CMD is the default set of arguments that are supplied to the ENTRYPOINT process.
There are also differences in how you override these values when you start a container:

CMD is easily overridden by appending your own arguments to the docker run command.
ENTRYPOINT can be changed using the --entrypoint flag, but this should rarely be necessary for container images being used in the way they were intended. If you do change the ENTRYPOINT, you’ll almost certainly need to set a custom CMD too—as otherwise, your new ENTRYPOINT is likely to receive arguments that it doesn’t understand.

### ARG and ENV

ARG:

ARG is used to define build-time variables.
These variables are only accessible during the image build process, not during the container runtime.
They are typically used to pass information to the Dockerfile from the outside at build time.
Common use cases include passing version numbers, file paths, or any other information that might change during the build process.
You can pass ARG values via the docker build command using the --build-arg flag.

```
ARG VERSION=latest
FROM ubuntu:${VERSION}

```
Then, you can build the Docker image with a specific version:

```
docker build --build-arg VERSION=20.04 .
```
ENV:

ENV is used to set environment variables that are available during the container runtime.
These variables can be accessed by processes running inside the container.
They are typically used to configure software inside the container, such as setting paths, defining default configurations, or providing credentials.
ENV values can be hardcoded within the Dockerfile or passed dynamically during container runtime.

```
FROM ubuntu
ENV PATH="/usr/local/bin:${PATH}"
```
Here, we're adding /usr/local/bin to the PATH environment variable inside the container.

In summary, ARG is used for build-time variables, while ENV is used for runtime environment variables inside the container.

### Docker python 

```
 Utilizamos una imagen oficial de Python como base
FROM python:3.9-slim

# Establecemos el directorio de trabajo en /app
WORKDIR /app

# Copiamos el archivo de requisitos a la imagen
COPY requirements.txt requirements.txt

# Instalamos las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos solo el archivo ejecutable de Python a la imagen
COPY app.py .

# Configuramos un usuario no root para la imagen por motivos de seguridad
RUN useradd appuser && chown -R appuser /app
USER appuser

# Exponemos el puerto 8080 para que la aplicación sea accesible desde fuera del contenedor
EXPOSE 8080

# Comando por defecto para ejecutar la aplicación
CMD ["python", "app.py"]

```

### A multistage Docker build 

is a technique used to optimize Docker images by using multiple stages in the Dockerfile. This allows you to separate different stages of the build process, reducing the final image size and improving build performance.

example of a Python Dockerfile with a multistage build:

```
# Stage 1: Build stage
FROM python:3.9-slim AS build-stage

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Python application code
COPY . .

# Stage 2: Production stage
FROM python:3.9-slim AS production-stage

# Set the working directory in the container
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build-stage /app /app

# Expose the port on which the application will run (if needed)
# EXPOSE 8000

# Define the command to run the Python application
CMD ["python", "app.py"]

```

### python optimized
```
# Stage 1: Build stage
FROM python:3.9-slim AS build-stage

# Set the working directory in the container
WORKDIR /app

# Copy the Python application code
COPY . .

# Install dependencies and create a virtual environment
RUN python -m venv /venv
RUN /venv/bin/pip install --no-cache-dir -r requirements.txt

# Stage 2: Production stage
FROM python:3.9-slim AS production-stage

# Set the working directory in the container
WORKDIR /app

# Copy only the virtual environment and the necessary files from the build stage
COPY --from=build-stage /venv /venv
COPY --from=build-stage /usr/local/bin/python /usr/local/bin/python
COPY --from=build-stage /usr/local/lib/python3.9 /usr/local/lib/python3.9

# Define the command to run the Python application
CMD ["/venv/bin/python", "app.py"]
```
In the build stage, we create a virtual environment (/venv) and install the Python dependencies inside it. Then we copy the entire application code into the image.

In the production stage, we copy only the virtual environment (/venv) and necessary Python executable and library files from the build stage into the production image. This includes the Python executable (/usr/local/bin/python) and the Python standard library (/usr/local/lib/python3.9).

Finally, we define the command to run the Python application using the Python executable from the virtual environment (/venv/bin/python).

With this setup, only the Python executable and necessary library files are copied into the production image, reducing its size and ensuring that only the essential components are included.

# Best practice

1. use lightweight base images
2. leverage multi-satge builds
3. minimiz the numebr of layers
4. cahce dependencies properly: leverage ocker layer caching by grouping stable dependencies at the top like package installation, before adding volatile content for example app code
5. use dockeignore
6. limit container privileges use non root useres in containrers
7. use volumes for data persistence
8. keep images up to date
9. use docker health checks


