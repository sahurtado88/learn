# APP Registration vs Service principal

App registration is globally unique instance of your app which lives in home tenant where app was registered. Service principle is local representation of your app which is used for all the management . Service principle enables your application to establish an identity for sign-in or access to resources.

# Storage QUEUES vs SERVICE BUS QUEUES

Storage queues and Service Bus queues have a slightly different feature set. You can choose either one or both, depending on the needs of your particular solution.

When determining which queuing technology fits the purpose of a given solution, solution architects and developers should consider these recommendations.

## Consider using Storage queues
As a solution architect/developer, you should consider using Storage queues when:

Your application must store over 80 gigabytes of messages in a queue.
Your application wants to track progress for processing a message in the queue. It's useful if the worker processing a message crashes. Another worker can then use that information to continue from where the prior worker left off.
You require server side logs of all of the transactions executed against your queues.

## Consider using Service Bus queues (fifo)
As a solution architect/developer, you should consider using Service Bus queues when:

Your solution needs to receive messages without having to poll the queue. With Service Bus, you can achieve it by using a long-polling receive operation using the TCP-based protocols that Service Bus supports.
Your solution requires the queue to provide a guaranteed first-in-first-out (FIFO) ordered delivery.
Your solution needs to support automatic duplicate detection.
You want your application to process messages as parallel long-running streams (messages are associated with a stream using the session ID property on the message). In this model, each node in the consuming application competes for streams, as opposed to messages. When a stream is given to a consuming node, the node can examine the state of the application stream state using transactions.
Your solution requires transactional behavior and atomicity when sending or receiving multiple messages from a queue.
Your application handles messages that can exceed 64 KB but won't likely approach the 256 KB or 1 MB limit, depending on the chosen service tier (although Service Bus queues can handle messages up to 100 MB).
You deal with a requirement to provide a role-based access model to the queues, and different rights/permissions for senders and receivers. For more information, see the following articles:
Authenticate with managed identities
Authenticate from an application
Your queue size won't grow larger than 80 GB.
You want to use the AMQP 1.0 standards-based messaging protocol. For more information about AMQP, see Service Bus AMQP Overview.
You envision an eventual migration from queue-based point-to-point communication to a publish-subscribe messaging pattern. This pattern enables integration of additional receivers (subscribers). Each receiver receives independent copies of either some or all messages sent to the queue.
Your messaging solution needs to support the "At-Most-Once" and the "At-Least-Once" delivery guarantees without the need for you to build the additional infrastructure components.
Your solution needs to publish and consume batches of messages.


If you want to	Use this
Connect everything from virtual machines to incoming VPN connections	Azure Virtual Network
Balance inbound and outbound connections and requests to applications	Azure Load Balancer
Protect your applications from DDoS attacks	Azure DDoS Protection
Native firewall capabilities with built-in high availability and zero maintenance	Azure Firewall
Manage network security policy and routing centrally	Azure Firewall Manager
Private and fully managed RDP and SSH access to your virtual machines	Azure Bastion
Private access to services hosted on the Azure platform	Azure Private Link
Route incoming traffic for better performance and availability	Traffic Manager
Monitor and diagnose network issues	Network Watcher
Extend Azure management for deploying 5G and SD-WAN network functions on edge devices	Azure Network Function Manager
Add private network connectivity from your corporate network to cloud	Azure ExpressRoute
Connect business offices, retail locations, and sites securely with a unified portal	Azure Virtual WAN
Securely use the internet to access Azure Virtual Networks	Azure VPN Gateway
Choose how your traffic routes between Azure and the Internet	Routing preference
Provide real-time customer experiences with ultra-low-latency edge compute	Azure Public MEC, Azure Private MEC
Simplify delivery of 5G wireless networks and manage private 5G	Azure Private 5G Core
Accelerate the delivery of high-bandwidth content to customers worldwide	Azure CDN
Scalable, security-enhanced delivery point for global, microservice-based web applications	Azure Front Door
Manage traffic to your web applications with a web traffic load balancer.	Azure Application Gateway
Use a firewall service for web apps to help improve web app security	Azure Web Application Firewall
Ensure ultra-fast DNS responses and availability for your domain needs.	Azure DNS
Test how networking infrastructure changes will impact performance	Internet Analyzer
Provide highly scalable, resilient, and secure outbound connectivity for virtual networks	Azure NAT Gateway
Create cloud and edge-native applications that interact with the intelligence of network.	Azure Programmable Connectivity
Modernize your network with a flexible, scalable 5G technology mobile packet core.	Azure Operator 5G Core

# Network

- virtual network
- virtual peering connect to virtual network
- vpn gateway connect to virtual network

VNet peering – connecting VNets within the same Azure region
Global VNet peering – connecting VNets across Azure regions

A VPN gateway is a specific type of VNet gateway that is used to send traffic between an Azure virtual network and an on-premises location over the public internet. You can also use a VPN gateway to send traffic between VNets. Each VNet can have only one VPN gateway.

VNet Peering provides a low latency, high bandwidth connection useful in scenarios such as cross-region data replication and database failover scenarios. Since traffic is completely private and remains on the Microsoft backbone, customers with strict data policies prefer to use VNet Peering as public internet is not involved. Since there is no gateway in the path, there are no extra hops, ensuring low latency connections.

VPN Gateways provide a limited bandwidth connection and is useful in scenarios where encryption is needed, but bandwidth restrictions are tolerable. In these scenarios, customers are also not as latency-sensitive.

VNet Peering and VPN Gateways can also co-exist via gateway transit
Gateway transit enables you to use a peered VNet’s gateway for connecting to on-premises instead of creating a new gateway for connectivity. As you increase your workloads in Azure, you need to scale your networks across regions and VNets to keep up with the growth. Gateway transit allows you to share an ExpressRoute or VPN gateway with all peered VNets and lets you manage the connectivity in one place. Sharing enables cost-savings and reduction in management overhead.

With gateway transit enabled on VNet peering, you can create a transit VNet that contains your VPN gateway, Network Virtual Appliance, and other shared services. As your organization grows with new applications or business units and as you spin up new VNets, you can connect to your transit VNet with VNet peering. This prevents adding complexity to your network and reduces management overhead of managing multiple gateways and other appliances.

https://azure.microsoft.com/en-us/blog/vnet-peering-and-vpn-gateways/

# ASG (4 layer) vs NSG (3 and 4 layer)

- Network security groups allow specific (NSG) are utilized to filter network traffic between Azure resources within a virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.
- Application security groups (ASG) control access and manage communication between:

Individual workloads hosted on one or more Azure VNets.
Connectivity between on-prem environments and Azure via an Application Gateway, VPN Gateway, Azure Firewall, Azure Bastion service, and Virtual Network Appliances.
Connections to and from the Internet.

Key Differences between ASGs and NSGs
Layer of Operation: ASGs operate at the transport layer (Layer 4), while NSGs operate at both the network layer (Layer 3) and the transport layer (Layer 4).
Scope: ASGs are primarily used for managing security between different application tiers, while NSGs focus on network-level security, controlling traffic flow within subnets, between subnets, and between virtual networks.
Granularity: ASGs offer granular control over network traffic by allowing rules based on source and destination IP addresses and source and destination ports. NSGs provide broader network-level control, including protocol-based filtering.
Application vs. Network: ASGs are tailored for securing application components and enforcing policies specific to application tiers. NSGs, on the other hand, are designed for securing network infrastructure and implementing network-level security policies.

Application Security Groups (ASGs) and Network Security Groups (NSGs) are two important tools available in Azure to enhance the security of your deployments. ASGs provide application-centric security by enabling fine-grained control over network traffic between different tiers of an application. On the other hand, NSGs offer network-level security by controlling traffic flow within subnets, between subnets, and between virtual networks.

- Virtual network gateway (VPN gateway) conect on premises and virtual network over public internet

# Azure load balancer vs application gateway
- Azure load balancer distribution of traffic different virtual machines public load balancer and internal load balancer hig availability and scalability scnenarios works with TCP and UDP

- application gateway  web traffica load balancer, web application firewall, redirection session affinity URL routing SSL termination

- content delivery network (CDN) deliver web contetn to users, minimize latency, POP (point of presense locations)

# difference between Azure Virtual Machines and Azure App Services.

Azure Virtual Machines provide infrastructure as a service (IaaS) and allow you to manage the virtualized infrastructure, including operating systems. Azure App Services, on the other hand, provide platform as a service (PaaS) and abstract away the underlying infrastructure, allowing developers to focus on application development without worrying about managing the underlying infrastructure.

# Azure Resource Manager (ARM), and why is it important?

Azure Resource Manager is the deployment and management service for Azure. It provides a consistent management layer that enables you to create, update, and delete Azure resources in a declarative way. It’s important because it allows for resource grouping, role-based access control, and resource lifecycle management.

# How would you ensure the security of resources deployed in Azure?

I would ensure the security of Azure resources by implementing a combination of best practices, such as role-based access control (RBAC), network security groups (NSGs), encryption at rest and in transit, Azure Security Center for continuous monitoring and threat detection, Azure Key Vault for managing keys and secrets, and compliance with relevant regulatory standards.

# Azure DevOps and its key components.

Azure DevOps is a set of cloud-based collaboration tools for software development, including version control, build automation, release management, and agile planning. Its key components include Azure Repos (for version control), Azure Pipelines (for CI/CD), Azure Boards (for agile planning), Azure Artifacts (for package management), and Azure Test Plans (for testing).

# Azure Functions, and when would you use them?

Azure Functions is a serverless compute service that allows you to run event-triggered code without provisioning or managing servers. You would use Azure Functions for running small pieces of code (functions) in response to various events, such as HTTP requests, timer triggers, or messages from Azure Service Bus or Azure Queue Storage. It’s ideal for scenarios like data processing, IoT, or automation tasks.

# monitor and troubleshoot Azure resources?

I monitor Azure resources using Azure Monitor, which provides metrics, logs, and alerts for monitoring the performance and health of resources. For troubleshooting, I would leverage tools like Azure Diagnostics, Azure Log Analytics, and Azure Application Insights to identify and diagnose issues, analyze logs, and gain insights into application performance.

#  Azure Virtual Network (VNet) and its components.

Azure Virtual Network is a logically isolated network in Azure that enables you to securely connect Azure resources and extend your on-premises network to the cloud. Its components include subnets, network security groups (NSGs) for controlling traffic, virtual network gateways for connecting VNets across regions or to on-premises networks, and Azure VPN Gateway and Azure ExpressRoute for secure connectivity.

# Explain the benefits of using Azure over on-premises infrastructure.

Answer: Benefits include:
Scalability: Easily adjust resources up or down based on needs.
Cost-effectiveness: Pay only for what you use.
Reliability: Built-in redundancy and disaster recovery for high availability.
Agility: Faster deployment and innovation cycles.
Security: Comprehensive security features and compliance standards.

# Describe different Azure storage solutions (e.g., Blob storage, Azure Files, Azure Disks) and their use cases.

Answer:
Blob storage: Ideal for unstructured data like media files and backups.
Azure Files: Provides cloud-based file shares accessible from Windows, Linux, and macOS machines.
Azure Disks: Managed block storage for VMs, offering high performance and scalability.

# Azure App Service vs Azure Functions for deploying web applications.

Answer:
App Service: Fully managed PaaS for building and deploying web apps, APIs, and mobile backends. Offers various frameworks and scaling options.
Azure Functions: Serverless compute platform for running small code snippets triggered by events. Ideal for microservices and event-driven architectures.

# .How can you implement disaster recovery for an Azure application using Azure Site Recovery?

Answer: Azure Site Recovery provides replication and failover capabilities between on-premises and Azure environments for disaster recovery.

# security best practices for deploying applications in Azure.

Answer: Best practices include:
Using least privilege access controls.
Restricting inbound and outbound traffic using network security groups.
Regularly patching and updating systems.
Encrypting data at rest and in transit.

# A critical database server in Azure fails. How would you recover from this outage?

Answer: You could use Azure Backup to restore the database from a recent backup.
If configured for geo-redundancy, failover to the secondary database in a different region would minimize downtime.

# We need to migrate our on-premises VMs to Azure. Explain the different migration strategies available.

Answer: Migration strategies include:
Lift-and-shift migration: Move VMs to Azure VMs with minimal changes.
Azure Database Migration Service: Streamline database migration to Azure SQL Database.
Azure Site Recovery: Replicate VMs to Azure for disaster recovery with potential for failover.

# IAS. PAS, SAS

Infrastructure as a Service(IaaS) : It provides users with components such as OS, networking capabilities, etc. This is a paid service, based on usage and can be used to host applications.

Platform as a Service(PaaS) It enables developers to build and work with applications without having to worry about the infrastructure or management of the hosting environment.

Software as a Service(SaaS) 
It involves applications being consumed and used by organizations. Usually, organizations pay for their use of the application

#  What are the deployment environments offered by Azure?
Azure offers two deployment environments:

Staging Environment
It provides a platform to validate changes to your application before it can be made live in the production environment.
In this stage, the app can be identified using the Azure’s Globally Unique Identifier (GUID) in URL form (GUID.cloudapp.net).
Production Environment
This environment is used to store the live application.
It can be differentiated from the staging environment with a more DNS-friendly URL (servicename.cloudapp.net).

# What are the types of Queues offered by Azure?
Azure offers two types of queues:

Storage Queues
It is a part of Azure’s Storage infrastructure.
It provides messaging within and between services.
It is best suited when users need to store more than 80 GB of messages in queues.
It can provide side logs of all transactions executed against the user’s queues.
Service Bus Queues
It is a part of Azure’s messaging infrastructure.
It integrates application or application components that span multiple communication protocols, network environments, etc.
It provides a FIFO style of delivery.
The user’s queue size has to remain under 80 GB.

# What are the advantages of the Azure Resource Manager?
Azure Resource Manager enables users to manage their usage of application resources. Few of the advantages of Azure Resource Manager are:

ARM helps deploy, manage and monitor all the resources for an application, a solution or a group.
Users can be granted access to the resources they require.
It obtains comprehensive billing information for all the resources in the group.
Provisioning resources is made much easier with the help of templates.

# What is the Federation in Azure SQL?
SQL Azure Federation provides tools that can enable developers to access or share databases among themselves in SQL Azure.

It enables users to take advantage of resources within the cloud.
It allows users to have their own database or share databases amongst each other.
It reduces the possibility of a single point of failure.
It provides cost-effectiveness, by using cloud resources only when needed.

# What are the different types of storage offered by Azure?
Storage questions are very commonly asked during an Azure Interview. Azure has four different types of storage. They are:

Azure Blob Storage 
Blob Storage enables users to store unstructured data that can include pictures, music, video files, etc. along with their metadata. 

When an object is changed, it is verified to ensure it is of the latest version. 
It provides maximum flexibility to optimize the user’s storage needs. 
Unstructured data is available to customers through REST-based object storage.
Azure Table Storage
Table Storage enables users to perform deployment with semi-structured datasets and a NoSQL key-value store. 

It is used to create applications requiring flexible data schema.
It follows a strong consistency model, focusing on enterprises.
Azure File Storage
File Storage provides file-sharing capabilities accessible by the SMB (Server Message Block) protocol

The data is protected by SMB 3.0 and HTTPS.
Azure takes care of managing hardware and operating system deployments.
It improves on-premises performance and capabilities.
Azure Queue Storage
Queue Storage provides message queueing for large workloads

It enables users to build flexible applications and separate functions.
It ensures the application is scalable and less prone to individual components failing.
It enables queue monitoring which helps ensure customer demands are met.

# What is Azure Service Fabric?
Service Fabric provides a platform that makes the process of developing microservices and managing the application lifecycle easier.

It produces applications with a faster time to market.
It supports Windows/ Linux, on-premises, and other clouds.
It provides the ability to scale up to a thousand machines.

# How can Azure handle this situation?
A client wants the front end of his/ her application to be hosted on Azure, but wants the database to be hosted on-premises.

Solution: The ideal solution in this scenario is to use Azure VNET-based “Point to Site.” It’s best suited for scenarios where there are only a limited number of resources that need to be connected.

# Azure Traffic Manager?
Azure Traffic Manager is a traffic load balancer that enables users to provide high availability and responsiveness by distributing traffic in an optimal manner across global Azure regions.

It provides multiple automatic failover options.
It helps reduce application downtime.
It enables the distribution of user traffic across multiple locations.
It enables users to know where customers are connecting from.

# Azure ExpressRoute

ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection with the help of a connectivity provider. With ExpressRoute, you can establish connections to Microsoft cloud services, such as Microsoft Azure and Microsoft 365.

Connectivity can be from an any-to-any (IP VPN) network, a point-to-point Ethernet network, or a virtual cross-connection through a connectivity provider at a colocation facility. ExpressRoute connections offer more reliability, faster speeds, consistent latencies, and higher security than typical connections over the Internet, because they don’t go over the public Internet. For information on how to connect your network to Microsoft using ExpressRoute, see ExpressRoute connectivity models.

Colocated at a cloud exchange
If you're colocated in a facility with a cloud exchange, you can request for virtual cross-connections to the Microsoft cloud through the colocation provider’s Ethernet exchange. Colocation providers can offer either Layer 2 cross-connections, or managed Layer 3 cross-connections between your infrastructure in the colocation facility and the Microsoft cloud.

Point-to-point Ethernet connections
You can connect your on-premises datacenters or offices to the Microsoft cloud through point-to-point Ethernet links. Point-to-point Ethernet providers can offer Layer 2 connections.

Any-to-any (IPVPN) networks
You can integrate your WAN with the Microsoft cloud. IPVPN providers (typically MPLS VPN) offer any-to-any connectivity between your branch offices and datacenters. The Microsoft cloud can be interconnected to your WAN to make it appear like any other branch office. WAN providers typically offer managed Layer 3 connectivity. ExpressRoute capabilities and features are all identical across all of the above connectivity models.

Direct from ExpressRoute sites
You can connect directly into the Microsoft global network at a peering location strategically distributed across the world. ExpressRoute Direct provides dual 100-Gbps or 10-Gbps connectivity that supports Active/Active connectivity at scale.

# Azure Scale Sets and Availability Sets?
Azure Scale Sets allow automatic scaling of VMs based on demand, whereas Availability Sets ensure high availability by distributing VMs across multiple fault and update domains. Scale Sets provide scaling, and Availability Sets provide redundancy.

# State the difference between repetitive and minimal monitoring.
Verbose monitoring collects metrics based on performance. It allows a close analysis of data fed during the process of application.

On the other hand, minimal monitoring is a default configuration method. It makes the user of performance counters gathered from the operating system of the host.


