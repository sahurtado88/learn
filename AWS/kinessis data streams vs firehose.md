# Kinesis Data Streams vs Firehose

## Kinesis Data Streams 
- Streaming service for ingest at scale
- Write custom code (producer /
consumer)
- Real-time (~200 ms)
- Manage scaling (shard splitting /
merging)
- Data storage for 1 to 365 days
- Supports replay capability

## Kinesis Data Firehose

- Load streaming data into S3 / Redshift /
OpenSearch / 3rd party / custom HTTP
- Fully managed
- Near real-time
- Automatic scaling
- No data storage
- Doesn’t support replay capability