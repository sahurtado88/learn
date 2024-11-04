# Learn the key Kubernetes features and plugins while practicing DevOps workflows, from a container expert

## Kubernetes Architecture

### Core Components
A Kubernetes cluster consists of a control plane and one or more worker nodes. Here's a brief overview of the main components:

#### Control Plane Components
Manage the overall state of the cluster:

- kube-apiserver
The core component server that exposes the Kubernetes HTTP API
- etcd
Consistent and highly-available key value store for all API server data
- kube-scheduler
Looks for Pods not yet bound to a node, and assigns each Pod to a suitable node.
- kube-controller-manager
Runs controllers to implement Kubernetes API behavior.
- cloud-controller-manager (optional)
Integrates with underlying cloud provider(s).

#### Node Components
Run on every node, maintaining running pods and providing the Kubernetes runtime environment:

- kubelet
Ensures that Pods are running, including their containers.
- kube-proxy (optional)
Maintains network rules on nodes to implement Services.
- Container runtime
Software responsible for running containers

## Taints and Tolerations

Node affinity is a property of Pods that attracts them to a set of nodes (either as a preference or a hard requirement). Taints are the opposite -- they allow a node to repel a set of pods.

Tolerations are applied to pods. Tolerations allow the scheduler to schedule pods with matching taints. Tolerations allow scheduling but don't guarantee scheduling: the scheduler also evaluates other parameters as part of its function.

Taints and tolerations work together to ensure that pods are not scheduled onto inappropriate nodes. One or more taints are applied to a node; this marks that the node should not accept any pods that do not tolerate the taints.

```
kubectl taint nodes node1 key1=value1:NoSchedule

```

places a taint on node node1. The taint has key key1, value value1, and taint effect NoSchedule. This means that no pod will be able to schedule onto node1 unless it has a matching toleration.

The default Kubernetes scheduler takes taints and tolerations into account when selecting a node to run a particular Pod. However, if you manually specify the .spec.nodeName for a Pod, that action bypasses the scheduler; the Pod is then bound onto the node where you assigned it, even if there are NoSchedule taints on that node that you selected. If this happens and the node also has a NoExecute taint set, the kubelet will eject the Pod unless there is an appropriate tolerance set.

pod with toleration

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  tolerations:
  - key: "example-key"
    operator: "Exists"
    effect: "NoSchedule"

```

The allowed values for the effect field are:

- NoExecute
This affects pods that are already running on the node as follows:
Pods that do not tolerate the taint are evicted immediately
Pods that tolerate the taint without specifying tolerationSeconds in their toleration specification remain bound forever
Pods that tolerate the taint with a specified tolerationSeconds remain bound for the specified amount of time. After that time elapses, the node lifecycle controller evicts the Pods from the node.
- NoSchedule
No new Pods will be scheduled on the tainted node unless they have a matching toleration. Pods currently running on the node are not evicted.
- PreferNoSchedule
PreferNoSchedule is a "preference" or "soft" version of NoSchedule. The control plane will try to avoid placing a Pod that does not tolerate the taint on the node, but it is not guaranteed.

## Pods
Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.

A Pod is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers. A Pod's contents are always co-located and co-scheduled, and run in a shared context

### Pod disruption budgets
FEATURE STATE: Kubernetes v1.21 [stable]
Kubernetes offers features to help you run highly available applications even when you introduce frequent voluntary disruptions.

As an application owner, you can create a PodDisruptionBudget (PDB) for each application. A PDB limits the number of Pods of a replicated application that are down simultaneously from voluntary disruptions.


## Exploring  Types and definitions

kubectl api-resources
kubectl explain type
kubectl explain node.spec
kubectl explain node  --recursive

## Namespaces
In Kubernetes, namespaces provide a mechanism for isolating groups of resources within a single cluster. Names of resources need to be unique within a namespace, but not across namespaces. Namespace-based scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc.) and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc.).

### Initial namespaces
Kubernetes starts with four initial namespaces:

default
Kubernetes includes this namespace so that you can start using your new cluster without first creating a namespace.
kube-node-lease
This namespace holds Lease objects associated with each node. Node leases allow the kubelet to send heartbeats so that the control plane can detect node failure.
kube-public
This namespace is readable by all clients (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.
kube-system
The namespace for objects created by the Kubernetes system

### contorl plane pods

etcd is our etcd server

kube-apiserver is the API server

kube-controller-manager and kube-scheduler are other control plane components

coredns provides DNS-based service discovery (replacing kube-dns as of 1.11)

kube-proxy is the (per-node) component managing port mappings and such

<net name> is the optional (per-node) component managing the network overlay

the READY column indicates the number of containers in each pod

Note: this only shows containers, you won't see host svcs (e.g. microk8s)

Also Note: you may see different namespaces depending on setup

### Namespaces and other kubectl commands
We can use -n/--namespace with almost every kubectl command

Example:

kubectl create --namespace=X to create something in namespace X
We can use -A/--all-namespaces with most commands that manipulate multiple objects

Examples:

kubectl delete can delete resources across multiple namespaces

kubectl label can add/remove/update labels across multiple namespaces

https://kubernetes.io/docs/reference/kubectl/quick-reference/

# Deployment vs replica set

- A deployment is a high-level construct

    allows scaling, rolling updates, rollbacks

    multiple deployments can be used together to implement a canary deployment

    delegates pods management to replica sets

- A replica set is a low-level construct

    makes sure that a given number of identical pods are running

    allows scaling

    rarely used directly

## logs in real time
Just like docker logs, kubectl logs supports convenient options:

-f/--follow to stream logs in real time (à la tail -f)

--tail to indicate how many lines you want to see (from the end)

--since to get logs only after a given timestamp

View the latest logs of our ping command:

kubectl logs deploy/pingpong --tail 1 --follow
Leave that command running, so that we can keep an eye on these logs

## Deployments
A Deployment manages a set of Pods to run an application workload, usually one that doesn't maintain state.
A Deployment provides declarative updates for Pods and ReplicaSets.

You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate. You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.

## Service
Expose an application running in your cluster behind a single outward-facing endpoint, even when the workload is split across multiple backends.
In Kubernetes, a Service is a method for exposing a network application that is running as one or more Pods in your cluster.

There are different types of services:

ClusterIP, NodePort, LoadBalancer, ExternalName

There are also headless services

Services can also have optional external IPs

There is also another resource type called Ingress

(specifically for HTTP services)

### ClusterIP
It's the default service type

A virtual IP address is allocated for the service

(in an internal, private range; e.g. 10.96.0.0/12)

This IP address is reachable only from within the cluster (nodes and pods)

Our code can connect to the service using the original port number

Perfect for internal communication, within the cluster

### LoadBalancer
An external load balancer is allocated for the service

(typically a cloud load balancer, e.g. ELB on AWS, GLB on GCE ...)

This is available only when the underlying infrastructure provides some kind of "load balancer as a service"

Each service of that type will typically cost a little bit of money

(e.g. a few cents per hour on AWS or GCE)

Ideally, traffic would flow directly from the load balancer to the pods

In practice, it will often flow through a NodePort first

### NodePort
A port number is allocated for the service

(by default, in the 30000-32767 range)

That port is made available on all our nodes and anybody can connect to it

(we can connect to any node on that port to reach the service)

Our code needs to be changed to connect to that new port number

Under the hood: kube-proxy sets up a bunch of iptables rules on our nodes

Sometimes, it's the only available option for external traffic

(e.g. most clusters deployed with kubeadm or on-premises)

### ExternalName
Services of type ExternalName are quite different

No load balancer (internal or external) is created

Only a DNS entry gets added to the DNS managed by Kubernetes

That DNS entry will just be a CNAME to a provided record

Example:

kubectl create service externalname k8s --external-name kubernetes.io
Creates a CNAME k8s pointing to kubernetes.io

### Headless services
Sometimes, we want to access our scaled services directly:

if we want to save a tiny little bit of latency (typically less than 1ms)

if we need to connect over arbitrary ports (instead of a few fixed ones)

if we need to communicate over another protocol than UDP or TCP

if we want to decide how to balance the requests client-side

...

In that case, we can use a "headless service"

#### Creating a headless services
A headless service is obtained by setting the clusterIP field to None

(Either with --cluster-ip=None, or by providing a custom YAML)

As a result, the service doesn't have a virtual IP address

Since there is no virtual IP address, there is no load balancer either

CoreDNS will return the pods' IP addresses as multiple A records

This gives us an easy way to discover all the replicas for a deployment

### Ingress
Ingresses are another type (kind) of resource

They are specifically for HTTP services

(not TCP or UDP)

They can also handle TLS certificates, URL rewriting ...

They require an Ingress Controller to function


Rolling updates. new versions of cantainers are deployed progressively, rather than all containers at a time

## Services and endpoints
A service has a number of "endpoints"

Each endpoint is a host + port where the service is available

The endpoints are maintained and updated automatically by Kubernetes

Check the endpoints that Kubernetes has associated with our httpenv service:
kubectl describe service httpenv
In the output, there will be a line starting with Endpoints:.

That line will list a bunch of addresses in host:port format.

When we have many endpoints, our display commands truncate the list

kubectl get endpoints
If we want to see the full list, we can use a different output:

kubectl get endpoints httpenv -o yaml
These IP addresses should match the addresses of the corresponding pods:

kubectl get pods -l app=httpenv -o wide

