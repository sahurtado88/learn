# AWS Snow Family
- Highly-secure, portable devices to collect and process data at the
edge, and migrate data into and out of AWS

-  Data migration:snowcone, snowball edge, snowmobile
- Edge computing: snowcone, snowball Edge

AWS Snow Family: offline devices to perform data migrations
If it takes more than a week to transfer over the network, use Snowball devices!

# Snowball Edge (for data transfers)
- Physical data transport solution: move TBs or PBs of data in or out
of AWS
- Alternative to moving data over the network (and paying network
fees)
- Pay per data transfer job
- Provide block storage and Amazon S3-compatible object storage
- Snowball Edge Storage Optimized
- 80 TB of HDD capacity for block volume and S3 compatible object
storage
- Snowball Edge Compute Optimized
- 42 TB of HDD or 28TB NVMe capacity for block volume and S3
compatible object storage
- Use cases: large data cloud migrations, DC decommission, disaster
recovery

# AWS Snowcone & Snowcone SSD
- Small, portable computing, anywhere, rugged &
secure, withstands harsh environments
- Light (4.5 pounds, 2.1 kg)
- Device used for edge computing, storage, and data
transfer
- Snowcone – 8 TB of HDD Storage
- Snowcone SSD – 14 TB of SSD Storage
- Use Snowcone where Snowball does not fit (space-
constrained environment)
- Must provide your own battery / cables
- Can be sent back to AWS offline, or connect it to
internet and use AWS DataSync to send data

# AWS Snowmobile

- Transfer exabytes of data (1 EB = 1,000 PB = 1,000,000 TBs)
- Each Snowmobile has 100 PB of capacity (use multiple in parallel)
- High security: temperature controlled, GPS, 24/7 video surveillance
- Better than Snowball if you transfer more than 10 PB

# AWS Snow Family for Data Migrations

![alt text](image-58.png)

# Snow Family – Usage Process
1. Request Snowball devices from the AWS console for delivery
2. Install the snowball client / AWS OpsHub on your servers
3. Connect the snowball to your servers and copy files using the client
4. Ship back the device when you’re done (goes to the right AWS
facility)
5. Data will be loaded into an S3 bucket
6. Snowball is completely wiped

# What is Edge Computing?
- Process data while it’s being created on an edge location
- A truck on the road, a ship on the sea, a mining station underground...
- These locations may have
- Limited / no internet access
- Limited / no easy access to computing power
- We setup a Snowball Edge / Snowcone device to do edge computing
- Use cases of Edge Computing:
- Preprocess data
- Machine learning at the edge
- Transcoding media streams
- Eventually (if need be) we can ship back the device to AWS (for transferring data for example)

# Snow Family – Edge Computing
- Snowcone & Snowcone SSD (smaller)
- 2 CPUs, 4 GB of memory, wired or wireless access
- USB-C power using a cord or the optional battery
- Snowball Edge – Compute Optimized
- 104 vCPUs, 416 GiB of RAM
- Optional GPU (useful for video processing or machine learning)
- 28 TB NVMe or 42TB HDD usable storage
- Storage Clustering available (up to 16 nodes)
- Snowball Edge – Storage Optimized
- Up to 40 vCPUs, 80 GiB of RAM, 80 TB storage
- All: Can run EC2 Instances & AWS Lambda functions (using AWS IoT Greengrass)
- Long-term deployment options: 1 and 3 years discounted pricing

 # AWS OpsHub
- Historically, to use Snow Family devices, you
needed a CLI (Command Line Interface tool)
- Today, you can use AWS OpsHub (a software
you install on your computer / laptop) to
manage your Snow Family Device
- Unlocking and configuring single or clustered devices
- Transferring files
- Launching and managing instances running on Snow
Family Devices
- Monitor device metrics (storage capacity, active
instances on your device)
- Launch compatible AWS services on your devices
(ex: Amazon EC2 instances, AWS DataSync,
Network File System (NFS))

# Solution Architecture: Snowball into Glacier
- Snowball cannot import to Glacier directly
- You must use Amazon S3 first, in combination with an S3 lifecycle policy

