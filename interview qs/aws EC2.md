# EC2

EC2 is one of the most popular of AWS’ offering
• EC2 = Elastic Compute Cloud = Infrastructure as a Service
• It mainly consists in the capability of :
• Renting virtual machines (EC2)
• Storing data on virtual drives (EBS)
• Distributing load across machines (ELB)
• Scaling the services using an auto-scaling group (ASG)

## EC2 sizing & configuration options
• Operating System (OS): Linux, Windows or Mac OS
• How much compute power & cores (CPU)
• How much random-access memory (RAM)
• How much storage space:
    • Network-attached (EBS & EFS)
    • hardware (EC2 Instance Store)
• Network card: speed of the card, Public IP address
• Firewall rules: security group
• Bootstrap script (configure at first launch): EC2 User Data

## EC2 User Data
• It is possible to bootstrap our instances using an EC2 User data script.
• bootstrapping means launching commands when a machine starts
• That script is only run once at the instance first start
• EC2 user data is used to automate boot tasks such as:
• Installing updates
• Installing software
• Downloading common files from the internet
• Anything you can think of
• The EC2 User Data Script runs with the root user

## Security Groups
• Security Groups are the fundamental of network security in AWS
• They control how traffic is allowed into or out of our EC2 Instances.
• Security groups only contain allow rules
• Security groups rules can reference by IP or by security group
Acts as a firewall for associated Amazon EC2 instances.
Controls both inbound and outbound traffic at the instance level.
Evaluates all rules before deciding whether to allow traffic.
Has separate rules for inbound and outbound traffic.
Stateful (Return traffic is automatically allowed, regardless of any rules).

## EC2 Instances Purchasing Options

• On-Demand Instances – short workload, predictable pricing, pay by second
• Reserved (1 & 3 years)
    • Reserved Instances – long workloads
    • Convertible Reserved Instances – long workloads with flexible instances
• Savings Plans (1 & 3 years) –commitment to an amount of usage, long workload
• Spot Instances – short workloads, cheap, can lose instances (less reliable)
• Dedicated Hosts – book an entire physical server, control instance placement Bring Your
Own License
• Dedicated Instances – no other customers will share your hardware
• Capacity Reservations – reserve capacity in a specific AZ for any duration

## Private vs Public IP (IPv4)
Fundamental Differences

###  Public IP:
• Public IP means the machine can be identified on the internet (WWW)
• Must be unique across the whole web (not two machines can have the same public IP).
• Can be geo-located easily

### Private IP:
• Private IP means the machine can only be identified on a private network only
• The IP must be unique across the private network
• BUT two different private networks (two companies) can have the same IPs.
• Machines connect to WWW using a NAT + internet gateway (a proxy)
• Only a specified range of IPs can be used as private IP

## Placement Groups
• Sometimes you want control over the EC2 Instance placement strategy
• That strategy can be defined using placement groups
• When you create a placement group, you specify one of the following
strategies for the group:
    • Cluster—clusters instances into a low-latency group in a single Availability Zone
    • Spread—spreads instances across underlying hardware (max 7 instances per
    group per AZ)
    • Partition—spreads instances across many different partitions (which rely on
    different sets of racks) within an AZ. Scales to 100s of EC2 instances per group
    (Hadoop, Cassandra, Kafka)

## EBS Volume Types
• EBS Volumes come in 6 types
    • gp2 / gp3 (SSD): General purpose SSD volume that balances price and performance for
    a wide variety of workloads
    • io1 / io2 Block Express (SSD): Highest-performance SSD volume for mission-critical
    low-latency or high-throughput workloads
    • st1 (HDD): Low cost HDD volume designed for frequently accessed, throughput-
    intensive workloads
    • sc1 (HDD): Lowest cost HDD volume designed for less frequently accessed workloads