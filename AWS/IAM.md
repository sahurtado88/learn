# IAM Cross Account setup

This tutorial teaches you how to use a role to delegate access to resources in different AWS accounts called Destination and Originating. You share resources in one account with users in a different account. By setting up cross-account access in this way, you don't have to create individual IAM users in each account. In addition, users don't have to sign out of one account and sign in to another account to access resources in different AWS accounts. After configuring the role, you see how to use the role from the AWS Management Console, the AWS CLI, and the API.

Users in the Originating account (the trusted account) allowed to assume a specific role in the Destination account.

A role in the Destination account (the trusting account) allowed to access a specific Amazon S3 bucket.

The amzn-s3-demo-bucket-shared-container bucket in the Destination account.

Developers can use the role in the AWS Management Console to access the amzn-s3-demo-bucket-shared-container bucket in the Destination account. They can also access the bucket by using API calls authenticated by temporary credentials provided by the role. Similar attempts by an Analyst to use the role fail.

## This workflow has three basic steps:

### Create a role in the Destination Account
First, you use the AWS Management Console to establish trust between the Destination account (ID number 999999999999) and the Originating account (ID number 111111111111). You start by creating an IAM role named UpdateData. When you create the role, you define the Originating account as a trusted entity and specify a permissions policy that allows trusted users to update the amzn-s3-demo-bucket-shared-container bucket.

### Grant access to the role
In this section, you modify the role policy to deny Analysts access to the UpdateData role. Because Analysts have PowerUser access in this scenario, and you must explicitly deny the ability to use the role.

```
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Resource": "arn:aws:iam::DESTINATION-ACCOUNT-ID:role/UpdateData"
  }
}
```

### Test access by switching roles
Finally, as a Developer, you use the UpdateData role to update the amzn-s3-demo-bucket-shared-container bucket in the Destination account. You see how to access the role through the AWS console, the AWS CLI, and the API.

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListAllMyBuckets",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation"
       ],
      "Resource": "arn:aws:s3:::amzn-s3-demo-bucket-shared-container"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::amzn-s3-demo-bucket-shared-container/*"
    }
  ]
}
```

Using AssumeRole (AWS API)
When David needs to make an update to the Destination account from code, he makes an AssumeRole call to assume the UpdateData role. The call returns temporary credentials that he can use to access the amzn-s3-demo-bucket-shared-container bucket in the Destination account. With those credentials, David can make API calls to update the amzn-s3-demo-bucket-shared-container bucket. However, he cannot make API calls to access any other resources in the Destination account, even though he has power-user permissions in the Originating account.

To assume a role
David calls AssumeRole as part of an application. They must specify the UpdateData ARN: arn:aws:iam::999999999999:role/UpdateData.

The response from the AssumeRole call includes the temporary credentials with an AccessKeyId and a SecretAccessKey. It also includes an Expiration time that indicates when the credentials expire and you must request new ones. When you set up role chaining with the AWS SDK, many credential providers automatically refresh credentials before they expire.

With the temporary credentials, David makes an s3:PutObject call to update the amzn-s3-demo-bucket-shared-container bucket. They would pass the credentials to the API call as the AuthParams parameter. Because the temporary role credentials have only read and write access to the amzn-s3-demo-bucket-shared-container bucket, any other actions in the Destination account are denied.

