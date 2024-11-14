# Kinesis Data Streams
- Retention between 1 day to 365 days
- Ability to reprocess (replay) data
- Once data is inserted in Kinesis, it can’t be deleted (immutability)
- Data that shares the same partition goes to the same shard (ordering)
- Producers: AWS SDK, Kinesis Producer Library (KPL), Kinesis Agent
- Consumers:
    - Write your own: Kinesis Client Library (KCL), AWS SDK
    - Managed: AWS Lambda, Kinesis Data Firehose, Kinesis Data Analytics,

# Kinesis Data Streams – Capacity Modes
## Provisioned mode:
    - You choose the number of shards provisioned, scale manually or using API
    - Each shard gets 1MB/s in (or 1000 records per second)
    - Each shard gets 2MB/s out (classic or enhanced fan-out consumer)
    - You pay per shard provisioned per hour
## On-demand mode:
    - No need to provision or manage the capacity
    - Default capacity provisioned (4 MB/s in or 4000 records per second)
    - Scales automatically based on observed throughput peak during the last 30 days
    - Pay per stream per hour & data in/out per GB

# Kinesis Data Streams Security
- Control access / authorization using
IAM policies
- Encryption in flight using HTTPS
endpoints
- Encryption at rest using KMS
- You can implement
encryption/decryption of data on
client side (harder)
- VPC Endpoints available for Kinesis to
access within VPC
- Monitor API calls using CloudTrail

# Ordering data into Kinesis
• Imagine you have 100 trucks
(truck_1, truck_2, … truck_100) on
the road sending their GPS positions
regularly into AWS.
• You want to consume the data in
order for each truck, so that you can
track their movement accurately.
• How should you send that data into
Kinesis?
• Answer : send using a “Partition Key”
value of the “truck_id”
• The same key will always go to the
same shard

# Kinesis vs SQS ordering
• Let’s assume 100 trucks, 5 kinesis shards, 1 SQS FIFO
## Kinesis Data Streams:
• On average you’ll have 20 trucks per shard
• Trucks will have their data ordered within each shard
• The maximum amount of consumers in parallel we can have is 5
• Can receive up to 5 MB/s of data
## SQS FIFO
• You only have one SQS FIFO queue
• You will have 100 Group ID
• You can have up to 100 Consumers (due to the 100 Group ID)
• You have up to 300 messages per second (or 3000 if using batching)