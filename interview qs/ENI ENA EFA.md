# ENA (Elastic Network Adapter): 

ENA is an Amazon network technology that enables high-speed network performance on EC2 instances. ENA supports speeds up to 100 Gbps on larger instance types, making it ideal for workloads that require high bandwidth or low latency, such as data analysis or high-demand applications. To take advantage of ENA, both the EC2 instance and the operating system must be compatible.

# ENI (Elastic Network Interface): 

An ENI is a virtual network interface in AWS that can be attached to an EC2 instance. This interface has its own IP address, MAC address, security groups, and is associated with a subnet in a VPC. ENIs can be transferred between EC2 instances, allowing you to move network configurations between instances or implement high availability solutions.

# EFA (Elastic Fabric Adapter): 
EFA is a network interface designed for applications requiring extremely low latency and high inter-node communication capacity, such as high-performance computing or machine learning tasks. EFA provides network performance beyond what ENIs and ENAs offer, allowing applications to access the network hardware directly to reduce latency.

# EIP (Elastic IP Address):

 An EIP is a static IP address in AWS that you can associate with an EC2 instance. This is useful for services that need a fixed IP address since IP addresses in AWS can change when an instance is stopped and restarted. EIPs allow an EC2 instance to maintain the same public IP address over time.
