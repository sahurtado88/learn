# EFS to EFS DataSync Workflow

The following image shows the high level workflow of EFS to EFS data transfer using Datasync.
![alt text](image-14.png)


Here is how it works.

1. DataSync Agent EC2 instance will be created in the source account within the same region and subnet.
2. The DataSync Agent can access the source EFS via its mount point.
3. A VPC Peering connection (cross account) from the source to the destination secures private communication between networks.
4. A VPC Endpoint will be created in the destination account for the AWS DataSync Service, enabling secure communication.
5. The DataSync Agent instance in the source account writes data to the destination EFS account through the VPC Endpoint using ENIs.
6. AWS DataSync encrypts the data during transfer and allows scheduling and filtering it during migration.

## EFS to EFS DataSync Transfer Steps

Follow the steps given below to setup Datasync for EFS to EFS data transfer.

### Step 1: Source Account Elastic File System (EFS)
I already have an Elastic File System with data in the source account.

![alt text](image-15.png)

We can mount this to a server to check the available data in the file system.

I am mounting this EFS to an EC2 instance. For that, we need the EFS DNS name and other details.

![alt text](image-16.png)

The following window will give the mount command with the File System DNS name

![alt text](image-17.png)

Create an EC2 instance with Amazon Linux AMI, and use the following command to add the Network File System client.

```
sudo yum install -y amazon-efs-utils
```

Create a directory to mount the File System

```
mkdir efs
```

Paste the mount command from the above screenshot.

```
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport <EFS_DNS_NAME>:/ efs
```

After mounting the file system, we can view the available data in the efs directory.

![alt text](image-18.png)

Now, we will migrate this data to another EFS situated on another AWS account.

Ensure the EFS has mount points; otherwise, it cannot connect with other services.

![alt text](image-19.png)

### Step 2: Create VPCs in Both Accounts
First, we need to create a VPC in both accounts, and the CIDR values of both VPCs should be different.

Source AWS Account
Here, the source account VPC CIDR is 172.16.0.0/16, and the region I have chosen is  US-West-2.

![alt text](image-20.png)

Destination AWS Account
For the destination account, I have chosen the 10.0.0.0/16 CIDR VPC, and the region is us-east-1

![alt text](image-21.png)

### Step 3: VPC Peering
We use the Peering connection method to establish private communication between two different networks.

Source Account
First, we must establish the peering connection request from the source VPC.

![alt text](image-22.png)

On the next page, provide the required information.

![alt text](image-23.png)

After creating the peering connection, the request goes to the destination account, so we need to accept the request from the destination account.

Destination Account
The peering connection won’t be established until the request is accepted.

![alt text](image-24.png)

### Step 4: Update Route Table
We need to modify both VPC route tables to route the traffic between the two networks via the peering connection.

Source Account
First, we updated the source account’s VPC Route Table Rules.

![alt text](image-25.png)

Edit routes to add new routes. For the new route, the Destination is the destination VPC CIDR 10.0.0.0/16 , and the Target is the Peering Connection.

![alt text](image-26.png)

Destination Account
We update the destination account’s route table with the source VPC details.

![alt text](image-27.png)

### Step 5: Install Datasync Agent Instance
We need to create a Datasync AWS EC2 Agent instance in the source account.

The DataSync Agent instance should be in the same region and network as the source EFS to effectively read the data and reduce latency.

Source Account
To transfer data between EFS systems, we need a data transfer agent so that the agent can get the data from the source and store it in the destination file system.

To get the AMI of the DataSync Agent, use the following command.

You can use the cloud shell to run this command.

```
aws ssm get-parameter --name /aws/service/datasync/ami --region us-west-2
```

From the output, we can get the DataSync Agent AMI ID.

![alt text](image-28.png)

Create an EC2 instance using this AMI ID.

![alt text](image-29.png)

The AMI will be available in the community AMI’s section.

![alt text](image-30.png)

Note: The DataSync Agent should be created in the same network as the Source EFS to ensure it can access the EFS.

![alt text](image-31.png)

### Step 6: Create a VPC Endpoint in the Destination Account
We need a private VPC endpoint in the destination account to transfer data securely to an AWS service.

Destination Account
Navigate to the VPC dashboard and select the “Endpoints” tab.

![alt text](image-32.png)

In the next window, we need to choose the Service category as “AWS Service” because we are using this for internal service communication.

![alt text](image-33.png)

In the following section, select the AWS Service, destination VPC, Subnets, and Security group to attach to the VPC endpoint.

![alt text](image-34.png)

![alt text](image-35.png)

### Step 7: Setup DataSync in Destination
In the destination account, we need to set up the DataSync Agent with the VPC Endpoint and create source and destination locations with that Agent to perform the data sync between accounts.

Prerequisite
We need the IP address of the source account DataSync Agent instances for AWS DataSync activation.

Source Account
If your browser can access the Private IP of the Source DataSync Instance, you can use it to activate it. Otherwise, you use the public IP of the instance for the activation.

![alt text](image-36.png)

Note: If you haven’t establised a VPN connection, you cannot use the Private IP for DataSync Agent activation.

Refer to this blog to learn how to set up the AWS Client VPN. (https://devopscube.com/aws-client-vpn/)

Destination Account
Open the AWS DataSync Service from the destination account.

![alt text](image-37.png)

In the next window, choose the ‘Deploy agent as Amazon EC2‘, because our agent runs in the source as an EC2 instance.

In the ‘Service endpoint‘ section, select the VPC Endpoint we created in the previous steps.

The endpoint type should be VPC endpoints using AWS PrivateLink. We also need to select the VPC, Subnet, and security group.

![alt text](image-38.png)

In the Activation key section, provide the Public IP of the source DataSync Agent instance.

![alt text](image-39.png)

If you successfully activate the Agent, you will see the following output.

![alt text](image-40.png)

Now, we can create the Agent.

![alt text](image-41.png)

### Step 8: Create Destination Elastic File System (EFS)
We must create a destination EFS to migrate data from the source EFS.

![alt text](image-42.png)

Provide the destination VPC and Security Group in the settings to create the EFS.

![alt text](image-43.png)

### Step 9: Create DataSync Locations
Before creating the locations, we need one of the Mount Point IPs of the source EFS.

Source Account

![alt text](image-44.png)

Destination Account
Now, create a location for the source and destination.

![alt text](image-45.png)

First, we need to create a location for the source account. The location type should be NFS because the source EFS is in another account.

![alt text](image-46.png)

Now, we need to create a location for the destination EFS.

![alt text](image-47.png)

### Step 10: Setup DataSync Task
Now, we can set up the DataSync task to perform the migration.

![alt text](image-48.png)

First, we need to configure the source location.

![alt text](image-49.png)

Then, configure the destination location

![alt text](image-50.png)

Both locations are now configured, and the other configuration settings are performed.

Provide a name for the task. In the ‘Source Data Option’ Section, choose between Everything and Specific files, objects, and folders.

I need to transfer all data from the source account to the Destination account, so I am choosing Everything. However, you can exclude specific files, objects, or folders if required.

In the Transfer Options section, various configurations are available.

# Transfer Mode
1. Transfer all data: This will not compare the source and destination files; instead, it will directly proceed with copying.
2. Transfer only changed data: This option will compare the source and destination data before copying them. If any data is changed in the source or the destination doesn’t have that data, only the copy will happen.
## Verification
1. Verify all data: After transferring the data, verify all the source and destination data and ensure that the source and destination are properly synced.
2. Verify only transferred data.
3. Don’t verify data after transferred

## Bandwidth Limit
1. By default, DataSync will use a maximum bandwidth limit to transfer the data, but we can limit the bandwidth if required.
2. We can always keep the files in the destination location even if it is deleted from the source location.
3. Overwrite the data when the source data has any changes.

## Additional Settings
1. Copy Ownership: User and Group ID
2. Copy Permissions from the source
3. Copy Timestamps from the source
4. Queueing

Note: Depends on the configuration, the on premises to AWS data transfer bandwidth can go upto 10 Gbps.

![alt text](image-51.png)

In the Scheduling section, we can manually trigger the sync or configure it to occur periodically.

In the Task Repot section, we can create a standard or summary only report about the sync and can be stored in an S3 Bucket.

If choosing the Standard Report, you will get more customization options such as success and errors or errors only reports for (Transferred, Verified, Deleted, or Skipped)

In the Logging section, we can send the logs to AWS Cloudwatch.

![alt text](image-52.png)

The task is ready to perform the sync. We have to start the task.

![alt text](image-53.png)

Note: Each AWS DataSync task creates four Elastice Network Interfaces (ENIs) will be created. This will optimize the performance and helps for the fault tolerance.

### Step 11: Verify the DataSync
We can check the Task history to verify that the data is properly migrated from the source to the destination account.

![alt text](image-54.png)

In the history, you can see the execution details such as Execution ID, Start Time, Duration, Status, Transfer Speed, Size, etc.; if we want more information, we can click the execution ID.

![alt text](image-55.png)

You can also manually check if all the files have been synced by mounting the destination EFS to an EC2 instance.

![alt text](image-56.png)

With DayaSync, you can do more configuration and implementation. When you implement it, make sure that the security groups provide only the required network and ports to route the traffic.