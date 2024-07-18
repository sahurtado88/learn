# Pulumi


Pulumi's infrastructure-as-code SDK helps you create, deploy, and manage AWS containers, serverless functions, and infrastructure using programming languages like TypeScript, Python, Go, C#, and Java, and markup languages like YAML. The Pulumi AWS provider packages and CLI help you accomplish all these within minutes.

# First steps

1. Install pulumi
2. Install python
3. Configure Pulumi to access your AWS account. You must use an IAM user account that has programmatic access with rights to deploy and manage resources handled through Pulumi.

windows
```
$env:AWS_ACCESS_KEY_ID = "<YOUR_ACCESS_KEY_ID>";
 $env:AWS_SECRET_ACCESS_KEY = "<YOUR_SECRET_ACCESS_KEY>"

$env:AWS_PROFILE = "<YOUR_PROFILE_NAME>" # if you have profiles
```
Linux
```
export AWS_ACCESS_KEY_ID="<YOUR_ACCESS_KEY_ID>" && export AWS_SECRET_ACCESS_KEY="<YOUR_SECRET_ACCESS_KEY>"

export AWS_PROFILE="<YOUR_PROFILE_NAME>"

```

4. Create project
```
mkdir quickstart && cd quickstart && pulumi new aws-python
```
The pulumi new command creates a new Pulumi project with some basic scaffolding based on the cloud and language specified.



