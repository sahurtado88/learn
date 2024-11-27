# Kubernetes

- api server: entrypoint to K8s cluster, expose Kubernetes API

- controller manager: keeps track of whats happening in the cluster (node controller, replication controller, endpoint controller, service account and token controllers)

- Scheduler: ensures pods placement

- etcd: kubernetes backing store, key value store for critical cluster info

- si se desplega en nube se adiciona un nuevo elemento el cloud controller manager 

NODE PROCESS

each node has multiple POD in it

3 processes must be installed on every node

Worker Node do the actual work

  - CONTAINER RUNTIME (for example docker)
  - KUBELET interact with both the container runtime and node, starts the pod with a container inside
  - KUBEPROXY forwards the request, allow network communications

  ## YAML in kubernetes

always have 4 fields
- apiVersion: version create object (v1, apps/v1)
- kind: refers type of objects (pod, replicaset, deployment, service)
- metadata: is data about the object form or dictionary (name, labels) you can specify names or lables that k8s expect
- specs: aditional information to k8s esepcification depend on object (dictionary) - is a item in the list

## Workload kubernetes

###  Deployments: 
Deployments are a Kubernetes resource type used to manage and scale a set of identical Pods. A Deployment ensures that a specified number of Pod replicas are running at any given time, and it can perform rolling updates and rollbacks to the application.

###  StatefulSets:
 StatefulSets are used for stateful applications that require stable, unique network identifiers and persistent storage. They are useful for applications like databases where each instance needs its own identity and storage.

###  DaemonSets: 
DaemonSets ensure that all (or some) nodes run a copy of a Pod. They are typically used for system-level daemons, logging agents, or monitoring agents that need to run on every node.

###  Jobs: 
Jobs manage short-lived and batch workloads that run to completion, such as data processing tasks, backups, or periodic tasks. Once a Job completes successfully, Kubernetes terminates the Pod associated with the Job.

###  CronJobs: 
CronJobs are used to schedule Jobs to run at specific times or intervals, similar to the cron utility in Unix-like operating systems. They are useful for running periodic tasks, backups, or cleanup jobs.

###  Pods: 
While not technically a workload in itself, Pods are the smallest deployable units in Kubernetes. A Pod encapsulates one or more containers, storage resources, and network configurations. Pods can be managed directly, but they are often managed by higher-level controllers like Deployments or StatefulSets.

## Services types

In Kubernetes, Services are an abstraction that define a logical set of Pods and a policy by which to access them. Kubernetes Services enable network communication to Pods from both inside and outside of the cluster. There are several types of Services in Kubernetes:

### ClusterIP:

- This is the default type of Service in Kubernetes.
- Exposes the Service on a cluster-internal IP.
- The Service is only reachable from within the cluster.
- This type is commonly used for inter-service communication within the cluster.

### NodePort:

- Exposes the Service on a static port on each Node's IP.
The Service is accessible from outside the cluster using the <NodeIP>:<NodePort> combination.
- Kubernetes allocates a specific port (NodePort) on each node, and traffic is forwarded to the Service.
- This type is useful when you need to expose a Service externally, but it's not recommended for production use due to security concerns and limitations.

### LoadBalancer:

- Exposes the Service externally using a cloud provider's load balancer.
- The cloud provider allocates a load balancer, and traffic is routed to the Service's Pods.
- This type is useful for exposing Services externally in production environments.
- It's important to note that this type is only available if your Kubernetes cluster is running in a supported cloud provider environment.

###  ExternalName:

Maps the Service to the contents of the externalName field.
Allows access to external services by returning a CNAME record with the configured externalName.
This type is commonly used to integrate with external services that are not part of the Kubernetes cluster.

### Headless:

This is a special type of Service that does not have a cluster-internal IP.
It's used to create DNS records for individual Pods without load balancing or proxying.
When you query the DNS for the Service name, Kubernetes returns the IP addresses of the Pods directly.
This type is useful for stateful applications that require stable network identities, such as databases.

## Ingress

 Ingress provides a flexible and powerful way to expose HTTP and HTTPS routes from outside the Kubernetes cluster to services within the cluster. It enables sophisticated routing and traffic management capabilities, making it an essential component for managing external access to applications running in Kubernetes.

Ingress is the most useful if you want to expose multiple services under the same IP address, and these services all use the same L7 protocol (typically HTTP). You only pay for one load balancer if you are using the native GCP integration, and because Ingress is “smart” you can get a lot of features out of the box (like SSL, Auth, Routing, etc)

### Label and selectors

Labels are properties attach to each item, selector help to filters this items
annotation are use for other purpouse, detail, version, etc

### Taints and Tolerations

Node affinity is a property of Pods that attracts them to a set of nodes (either as a preference or a hard requirement). Taints are the opposite -- they allow a node to repel a set of pods.

Tolerations are applied to pods. Tolerations allow the scheduler to schedule pods with matching taints. Tolerations allow scheduling but don't guarantee scheduling: the scheduler also evaluates other parameters as part of its function.

### Cordon and Drain 

- Cordon:

- When you "cordon" a node, you mark it as unschedulable. This means that no new Pods will be scheduled onto the node.
- Existing Pods on the node will continue to run as usual.
- Cordon prevents the Kubernetes scheduler from placing new Pods onto the node, ensuring that no additional workload is assigned to a node that is about to be taken offline for maintenance.

- Drain:

- When you "drain" a node, you evict all the Pods running on the node and mark the node as unschedulable.
- Evicting Pods means gracefully terminating them and rescheduling them onto other nodes in the cluster.
- The Kubernetes scheduler ensures that evicted Pods are rescheduled onto other nodes that have sufficient resources.
- Drain also ensures that any local storage associated with the node is safely unmounted or moved to another node to prevent data loss.
- Drain is typically used when you want to decommission a node for maintenance, such as applying updates, replacing hardware, or scaling down the cluster.

In summary, "cordon" prevents new Pods from being scheduled onto a node, while "drain" safely evicts existing Pods from a node and marks it as unschedulable, allowing for maintenance or decommissioning tasks to be performed without disrupting running workloads. These commands are essential for ensuring high availability and reliability in Kubernetes clusters during node maintenance operations.

### PDB

Pod Disruption Budget (PDB) is a policy object that allows you to control the disruption caused by voluntary disruptions, such as evictions due to node maintenance or scale-down operations. PDBs ensure that a specified number of Pods belonging to a replication controller, replica set, or stateful set are available during voluntary disruptions, thus ensuring the high availability of your application.

### Node Affinity

Node affinity is conceptually similar to nodeSelector, allowing you to constrain which nodes your Pod can be scheduled on based on node labels.

### CONFIGMAP

A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

### Sidecar and Init container

#### Init Containers:

- Init containers are specialized containers that run before the main application containers in a Pod.
- They are primarily used for performing initialization tasks or setup procedures that need to be completed before the main application container starts.
- Init containers run to completion before any other containers in the Pod start, and they share the same network namespace and storage volumes with the main containers.
- Common use cases for init containers include:
  - Downloading and unpacking data or configuration files.
  - Performing database schema migrations or setup tasks.
  - Initializing shared storage volumes.
- Init containers provide a way to decouple complex initialization logic from the main application container, improving maintainability and flexibility.

#### Sidecar Containers:

- Sidecar containers are additional containers that run alongside the main application container in a Pod.
- They are used to extend or enhance the functionality of the main application container without modifying its code or configuration.
- Sidecar containers share the same lifecycle as the main application container and are co-located on the same Pod, allowing them to communicate over localhost.
- Common use cases for sidecar containers include:
  - Logging: A sidecar container can collect logs from the main application container and forward them to a centralized logging service.
  - Monitoring: A sidecar container can collect metrics and monitor the health of the main application container.
  - Proxying or networking: A sidecar container can handle network traffic routing, load balancing, or encryption for the main application container.
- Sidecar containers provide a modular and composable architecture for extending the functionality of applications running in Kubernetes, enabling features such as logging, monitoring, security, and networking to be added independently of the main application logic.

## HPA policy

HPA policies provide fine-grained control over how Kubernetes autoscales deployments and replica sets based on resource utilization metrics and custom metrics. By configuring HPA policies, you can ensure that your applications automatically scale up or down to handle changes in demand while optimizing resource utilization and maintaining performance.

## Liveness and Readiness probe

 liveness probes and readiness probes in Kubernetes lies in their purpose and effect on the functioning of a Pod:

- Liveness Probe:

Purpose: The liveness probe determines whether the containers within a Pod are still running and healthy.

Effect: If the liveness probe fails, Kubernetes restarts the affected container.

Use Case: Liveness probes are useful for detecting and recovering from situations where the application within the container has crashed or become unresponsive. They help maintain the overall health of the application by ensuring that Kubernetes replaces failed containers automatically.

- Readiness Probe:

Purpose: The readiness probe determines whether the containers within a Pod are ready to start serving traffic.

Effect: If the readiness probe fails, Kubernetes stops sending network traffic to the affected Pod.

Use Case: Readiness probes are used to prevent sending traffic to Pods that are not yet fully initialized or are experiencing issues that could cause them to serve errors or degrade performance. They allow Kubernetes to ensure that only Pods in a fully operational state receive network traffic.

In summary, while both liveness and readiness probes help ensure the reliability and availability of applications running in Kubernetes, they serve different purposes. Liveness probes detect and recover from failures within containers, while readiness probes control when Pods are considered ready to receive network traffic. Both probes are essential for managing the lifecycle of Pods effectively and maintaining the overall health of applications in a Kubernetes cluster.

## Control plane and data plane

Control plane is responsible for managin and cotrolling the overall state of the system in kubernetes has 4 major component (contorller, api server, etcdand scheduler

Data plane is responsbile for managng the traffic that flows through the system)

## POD and COntainer

Pod is the smallest deployable object in kubernetes and represents one or more container, A container is a lightweight, standalone, and executable software package that includes everything needed to run a piece of software, including the code, runtime, system libraries, and settings. 

## StatefulSet

Like a Deployment, a StatefulSet manages Pods that are based on an identical container spec. Unlike a Deployment, a StatefulSet maintains a sticky identity for each of its Pods. These pods are created from the same spec, but are not interchangeable: each has a persistent identifier that it maintains across any rescheduling

StatefulSets are valuable for applications that require one or more of the following.

Stable, unique network identifiers.
Stable, persistent storage.
Ordered, graceful deployment and scaling.
Ordered, automated rolling updates.

# Operators

“Operator” in a simple way: “Operators are software extensions that use custom resources to manage applications and their components“
 In other words, using Operators enables us to view an application as a single object that exposes only the adjustments that make sense for the application, instead of a collection of primitives (such as Pods, Deployments, Services, or ConfigMaps).

# Custom Resource Definitions (CRD). 




# Image Pull Policy

The imagePullPolicy specification lets you specify how you want the Kubelet to pull an image if there’s any change (restart, update, etc.) to a Pod. When using the imagePullPolicy specification, you have three options:

- IfNotPresent: If you set the imagePullPolicy to IfNotPresent, Kubernetes will only pull the image when it doesn’t already exist on the node.
- Always: With your imagePullPolicy set to Always, Kubernetes will always pull the latest version of the image from the container registry. 
- Never: If you set the imagePullPolicy to Never, there will be no attempts to pull the image. 

## Default image pull policy
You may ask what happens when the imagePullPolicy specification isn’t defined in a manifest file — just like in the above manifest file. Well, in that case:

- If the image tag is :latest, the imagePullPolicy will be automatically set to Always. 
- If the image tag isn’t :latest, the imagePullPolicy will be automatically set to IfNotPresent. 
- And if you don’t set any image tag, the imagePullPolicy will be automatically set to latest image and Always value.

# imagePullSecrets

An imagePullSecrets is an authorization token, also known as a secret, that stores Docker credentials that are used for accessing a registry. The imagePullSecrets can be used when installing software that requires entitlement.