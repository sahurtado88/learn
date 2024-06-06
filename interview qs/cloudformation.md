# CLOUDFORMATION

1. What is AWS CloudFormation, and how does it fit into a DevOps environment?

Answer: AWS CloudFormation is a service that allows you to provision and manage AWS infrastructure as code. In a DevOps environment, CloudFormation enables the
 automated and repeatable creation of AWS resources, making it an essential tool for infrastructure deployment and management.

# stack and its components.

Answer: An AWS CloudFormation stack is a collection of AWS resources defined in a CloudFormation template. Stack components include the template, the stack name, 
and the set of resources created and managed by that stack.

3. What are AWS CloudFormation templates, and in what formats can they be written?

Answer: AWS CloudFormation templates are JSON or YAML text files that define the AWS resources and their configurations. You can write templates in either JSON or YAML format. YAML is often preferred for its human-readable and concise syntax.

4. How does CloudFormation support the concept of Infrastructure as Code (IaC), and what are the advantages of using IaC for infrastructure management?

Answer: CloudFormation supports IaC by allowing infrastructure to be defined and managed in code. IaC provides advantages such as version control, repeatability, 
documentation, and automated provisioning, resulting in more reliable and maintainable infrastructure.

# CloudFormation stack policies

Answer: CloudFormation stack policies are JSON documents that control what can be updated in a stack. They allow you to specify which resources are immutable, 
ensuring that specific resources are not modified during stack updates.

# Intrinsic functions in CloudFormation templates and provide examples of when to use functions like `Fn::Ref` or `Fn::Sub`.

Intrinsic functions are used for dynamic value generation in CloudFormation templates. For example:
— `Fn::Ref` is used to reference other resources.
— `Fn::Sub` is used for variable substitution.
These functions are helpful for creating templates with dynamic behavior.

7. How can you handle sensitive data such as passwords or API keys in CloudFormation templates securely?

 Sensitive data should be handled using AWS Secrets Manager or AWS Systems Manager Parameter Store. You can reference these secure stores in CloudFormation templates, ensuring that sensitive information is not exposed in the template itself.

# change set and a stack update? When would you use each?

A change set is a preview of the changes to a stack that will occur during an update. It allows you to review and understand the changes before they are applied. You would use a change set when you want to assess the impact of an update without actually making changes to the stack.

# handle dependencies between AWS resources in a CloudFormation template, and why is it important to define resource dependencies?

You handle dependencies using the `DependsOn` attribute in CloudFormation templates to specify the order in which resources are created or updated. Defining dependencies is essential for ensuring that resources are created or updated in the correct sequence, preventing issues related to resource availability.

10. Explain how you can extend CloudFormation templates using AWS Cloud Development Kit (CDK) or custom resources. When would you choose one method over the other?

You can extend CloudFormation templates using the AWS CDK to define templates programmatically in a programming language. Alternatively, you can use custom resources to extend templates with custom logic. The choice depends on your familiarity with the technologies and the complexity of the extensions required. CDK is often preferred for its ease of use and integrated development experience.

11. What is AWS CloudFormation drift detection, and how does it help maintain infrastructure integrity over time?

AWS CloudFormation drift detection allows you to detect and identify differences between the desired stack configuration defined in the template and the actual deployed stack. It helps ensure that the infrastructure remains in the desired state by identifying any configuration changes or drift.

12. Explain the process of creating and managing a stack in AWS CloudFormation. Provide an example command to create a stack.

You can create and manage a stack using the `aws cloudformation` commands. An example command to create a stack:

aws cloudformation create-stack — stack-name MyStack — template-body file://my-template.yaml

## CloudFormation helper scripts reference

AWS CloudFormation provides the following Python helper scripts that you can use to install software and start services on an Amazon EC2 instance that you create as part of your stack:

cfn-init: Use to retrieve and interpret resource metadata, install packages, create files, and start services.

cfn-signal: Use to signal with a CreationPolicy or WaitCondition, so you can synchronize other resources in the stack when the prerequisite resource or application is ready.

cfn-get-metadata: Use to retrieve metadata for a resource or path to a specific key.

cfn-hup: Use to check for updates to metadata and execute custom hooks when changes are detected.



1. What is CloudFormation? How can you use it to manage your infrastructure?

CloudFormation is an infrastructure automation platform that eliminates the need for setting up additional hardware, software and environments to deploy AWS resources. It allows you to scale or descale based on your immediate needs. You can also use it to integrate different AWS services through a single template. For example, it enables you to create a web application stack that contains an EC2 instance to create virtual machines, an RDS database to handle a database, an S3 bucket for storing static content and an Amazon CloudFront to improve the distribution of web application content.
Set up the infrastructure by writing a CloudFormation template in a JSON or YAML file. This template describes the resources you want to create, their properties and any interdependencies between them. Then provide this as input to create a CloudFormation Stack. Once CloudFormation creates the infrastructure based on the template, you can monitor it through the AWS Management Console. In case of an error, use the event logs to debug, make changes to the template file and re-upload it.
Related: 8 Popular AWS Certifications To Consider Pursuing

2. What is the difference between individual CloudFormation Stacks and CloudFormation StackSets?


Use CloudFormation Stacks to manage and deploy AWS resources within a single AWS account and StackSets for multiple AWS accounts or regions. In a simple deployment requiring a single AWS account, consider utilising CloudFormation Stacks. But if your deployment is large and complex, applying a CloudFormation StackSet simplifies the management of the resources and ensures consistency across multiple accounts and regions.


3. How does CloudFormation handle rollbacks in the case of a failed deployment?

There are instances where an update made to the stack fails due to template syntax errors, resource dependency issues, invalid property values or conflict with existing resources. This sometimes causes the deployment to halt. Interviewers ask this question to assess your understanding of CloudFormation's error-handling capabilities and your approach to solving deployment issues.
Example answer: CloudFormation performs a rollback operation that reverts the entire stack to its previous working state. This happens either due to a trigger during the deployment process or in response to a request for manual rollback. It also provides several error-handling features that help to mitigate the impact of failures during deployment. CloudFormation provides an event log that tracks the progress of each stack update. Reviewing the event log helps you learn about the reason for the failure.
As a first step, check the template to correct syntax errors or incorrect property values, modify the template and re-run it. You can also try changing the timeout values if a resource requires more time to create or update. Finally, look at updating IAM permissions if the error is due to a permission issue.
Related: 10 AWS Interview Questions And Answers

4. Can you use CloudFormation to deploy serverless applications and manage their underlying resources?

Yes, you can use CloudFormation to create, update and manage resources for serverless applications, such as AWS Lambda functions, Amazon API Gateway APIs and Amazon DynamoDB tables. The program allows you to define the resources required to create a stack in a serverless.yml file. You are also able to add other information, such as sensitive data or reusable configuration values, into this template. Adhering to a consistent naming scheme is necessary to deploy the serverless application successfully, so use the standard naming scheme that the documentation provides.
Related: 11 Lambda Interview Questions (With Sample Answers)

5. How does CloudFormation handle updates to the resources it manages?

Sometimes developers require changes to the current infrastructure to scale or descale the application. Interviewers often ask this question to assess your understanding of how CloudFormation manages such updates to the infrastructure. Answer this query by detailing the two techniques it provides to update the stacks.
Example answer: Direct update and change sets are two techniques CloudFormation provides to make changes to the existing infrastructure. If you want to deploy your updates quickly, opt for direct update. Here, CloudFormation simply updates the existing stack with the adjustments you provide.

In the second method, you add a list of alterations to the change set and upload it to CloudFormation in JSON format. This enables you to preview the adjustments to the stack before it deploys them. Here, CloudFormation compares the existing stack with the change set and applies any adjustments using a rolling update approach that updates one resource at a time. This allows it to roll back to the most recent stable version of the stack if an issue occurs. Use this to ensure CloudFormation does not introduce unintentional changes to the existing application when updating the stack.


6. How can you perform blue/green deployment using CloudFormation?

You can use the blue/green deployment strategy to transfer user traffic from the previous version of an application to the new one with zero downtime. This requires two identical CloudFormation Stacks, blue and green, one for each environment. The blue stack represents the existing version of the application's underlying environment or infrastructure, while the green stack denotes the application's updated environment. Use a load balancer such as AWS ELB to distribute the incoming user traffic to avoid application downtime. ELB distributes the traffic by monitoring the health of the registered targets and diverting traffic to the healthy target.
Here, the ELB routes the traffic to the blue stack while you update the green stack. After making the update, you can redirect the ELB to divert traffic to the green stack, which contains the updated infrastructure of the application. The deployment is complete after the entire user traffic diverts to the green stack. This approach provides an effective way to test and validate infrastructure changes or releases before making them live for users. Consider keeping the blue stack on standby to perform a rollback if there are any issues during the deployment.

https://datavalley.ai/aws-cloudformation-interview-questions/