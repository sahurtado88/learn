# 10 Best Python Scripts To Automate Your Daily Tasks in AWS

Understanding Python for AWS Automation
Python is one of the most versatile programming languages for cloud automation, thanks to its simplicity and strong support for AWS SDKs. Boto3, the AWS SDK for Python, enables smooth interaction with AWS services and is essential for running these automation scripts. To follow along, ensure:

- You have basic knowledge of Python.
- You’ve installed Boto3 (pip install boto3) and configured AWS CLI with necessary credentials (aws configure).
- You have appropriate IAM permissions for each script.

## 1. Automate EC2 Instance Start/Stop
- Purpose: Automatically start and stop EC2 instances to reduce costs during off-hours.
- Script:
```
import boto3
ec2 = boto3.client('ec2')

def manage_ec2(action, instance_ids):
    ec2.start_instances(InstanceIds=instance_ids) if action == 'start' else ec2.stop_instances(InstanceIds=instance_ids)
    print(f"Instances {action}ped: {instance_ids}")

manage_ec2('stop', ['i-1234567890abcdef0'])
```
- Setup: Define instance IDs and action (start or stop). Run this script manually or schedule it using AWS Lambda and CloudWatch Events.

2. Automated S3 Bucket Backup and Sync
Purpose: Sync data between two S3 buckets for backup.
Script:
```
import boto3
s3 = boto3.resource('s3')

def sync_s3_buckets(source_bucket, destination_bucket):
    copy_source = {'Bucket': source_bucket, 'Key': obj.key}
    for obj in s3.Bucket(source_bucket).objects.all():
        s3.Object(destination_bucket, obj.key).copy(copy_source)
    print(f"Data synced from {source_bucket} to {destination_bucket}")

sync_s3_buckets('source-bucket-name', 'destination-bucket-name')
```
Setup: Replace bucket names and run. Schedule with Lambda or as a local cron job.
3. DynamoDB Data Export to S3
Purpose: Regularly export data from DynamoDB tables to S3 for analytics or backup.
Script:
```
import boto3
dynamodb = boto3.resource('dynamodb')
s3 = boto3.client('s3')

def export_dynamodb_to_s3(table_name, bucket_name, file_name):
    table = dynamodb.Table(table_name)
    data = table.scan()['Items']
    s3.put_object(Bucket=bucket_name, Key=file_name, Body=str(data))
    print(f"Data exported to s3://{bucket_name}/{file_name}")

export_dynamodb_to_s3('my-table', 'my-bucket', 'backup.json')
```
Setup: Define table and bucket names, and run the script periodically.
4. RDS Instance Snapshot Backup
Purpose: Take regular snapshots of RDS instances to ensure data safety.
Script:
```
import boto3
rds = boto3.client('rds')

def create_rds_snapshot(db_instance_identifier, snapshot_id):
    rds.create_db_snapshot(DBSnapshotIdentifier=snapshot_id, DBInstanceIdentifier=db_instance_identifier)
    print(f"Snapshot {snapshot_id} created for {db_instance_identifier}")

create_rds_snapshot('my-db-instance', 'my-db-snapshot')
```
Setup: Replace db_instance_identifier and snapshot_id. Schedule through Lambda.
5. Automated Lambda Deployment
Purpose: Automatically deploy updated Lambda functions.
Script:
```
import boto3
lambda_client = boto3.client('lambda')

def deploy_lambda(function_name, zip_file_path):
    with open(zip_file_path, 'rb') as f:
        lambda_client.update_function_code(FunctionName=function_name, ZipFile=f.read())
    print(f"Lambda {function_name} updated successfully")

deploy_lambda('my-function', '/path/to/your/lambda.zip')
```
Setup: Package Lambda code as a .zip file and update function_name.
## 6. CloudWatch Alert Setup
- Purpose: Set up CloudWatch alerts for AWS resources.
- Script:
```
import boto3
cloudwatch = boto3.client('cloudwatch')

def create_cloudwatch_alarm(instance_id):
    cloudwatch.put_metric_alarm(
        AlarmName=f'CPU_Utilization_{instance_id}',
        MetricName='CPUUtilization',
        Namespace='AWS/EC2',
        Statistic='Average',
        Period=300,
        EvaluationPeriods=1,
        Threshold=70.0,
        ComparisonOperator='GreaterThanThreshold',
        AlarmActions=['<SNS_TOPIC_ARN>'],
        Dimensions=[{'Name': 'InstanceId', 'Value': instance_id}]
    )
    print(f"CloudWatch alarm created for {instance_id}")

create_cloudwatch_alarm('i-1234567890abcdef0')
```
- Setup: Replace <SNS_TOPIC_ARN> and instance_id.
## 7. Automated IAM User and Role Management
- Purpose: Automate management of IAM users, such as creating or deleting users.
- Script:
```
import boto3
iam = boto3.client('iam')

def create_iam_user(username):
    iam.create_user(UserName=username)
    print(f"IAM user {username} created")

create_iam_user('new-user')
```
- Setup: Define IAM username in the script.
## 8. Scheduled AMI Backup for EC2 Instances
- Purpose: Create AMIs for EC2 instances on a schedule.
- Script:
```
def create_ami(instance_id, ami_name):
    ec2 = boto3.client('ec2')
    ec2.create_image(InstanceId=instance_id, Name=ami_name, NoReboot=True)
    print(f"AMI {ami_name} created for {instance_id}")

create_ami('i-1234567890abcdef0', 'my-ami-backup')
```
- Setup: Schedule with CloudWatch Events and Lambda.
## 9. S3 Bucket Policy Management
- Purpose: Manage S3 bucket policies for secure access control.
- Script:
```
def update_s3_bucket_policy(bucket_name, policy):
    s3 = boto3.client('s3')
    s3.put_bucket_policy(Bucket=bucket_name, Policy=policy)
    print(f"Policy updated for {bucket_name}")
```
- Setup: Define policy JSON with the access rules.
# 10. Automate EBS Volume Snapshot Cleanup
- Purpose: Delete old EBS snapshots to control storage costs.
- Script:
```
import boto3
ec2 = boto3.client('ec2')

def cleanup_old_snapshots(days=30):
    snapshots = ec2.describe_snapshots(OwnerIds=['self'])['Snapshots']
    for snapshot in snapshots:
        age = (datetime.now(timezone.utc) - snapshot['StartTime']).days
        if age > days:
            ec2.delete_snapshot(SnapshotId=snapshot['SnapshotId'])
            print(f"Deleted snapshot {snapshot['SnapshotId']}")

cleanup_old_snapshots()
```
- Setup: Adjust days based on retention policy.
# Setting Up and Running Python Scripts in AWS
To run these scripts, set up Python and Boto3 locally or in an AWS Lambda environment. Proper IAM permissions and secure AWS CLI credential management are essential for safe automation.