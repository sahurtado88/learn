# AWS CODEDEPLOY

Q1. What is AWS code deploy?
Ans
AWS CodeDeploy is a service that automates code deployments to any instance, including Amazon EC2 instances and instances running on-premises. AWS CodeDeploy makes it easier for you to rapidly release new features, helps you avoid downtime during deployment, and handles the complexity of updating your applications.

Q2. What types of applications can be deployed with AWS CodeDeploy?
Ans
AWS CodeDeploy can be used for deploying any type of application. To use AWS CodeDeploy, you specify the files to copy and the scripts to run on each instance during the deployment. AWS CodeDeploy is programming language and architecture agnostic, so you can use scripts for any custom deployment logic.

Q3. What operating systems does AWS CodeDeploy support?
Ans
AWS CodeDeploy supports a wide variety of operating systems. AWS CodeDeploy provides agents that have been tested on Amazon Linux, Red Hat Enterprise Linux, Ubuntu Server, and Microsoft Windows Server.

Q4. What is an application?
Ans
An application is a collection of software and configuration to be deployed to a group of instances. Typically, the instances in the group run the same software. For example, if you have a large distributed system, the web tier will likely constitute one application and the data tier another application.

Q5. What is a revision?
Ans
A revision is a specific version of deployable content, such as source code, post-build artifacts, web pages, executable files, and deployment scripts, along with an AppSpec file. The AWS CodeDeploy Agent can access a revision from GitHub or an Amazon S3 bucket.

Q6. What is a deployment group?
Ans
A deployment group is the AWS CodeDeploy entity for grouping EC2 instances or AWS Lambda functions in a CodeDeploy deployment. For EC2 deployments, it is a set of instances associated with an application that you target for a deployment. You can add instances to a deployment group by specifying a tag, an Auto Scaling group name, or both. In an AWS Lambda deployment, a deployment group defines a set of AWS CodeDeploy configurations for future serverless Lambda deployment to the group, like alarms and rollbacks.

Q7. What is a deployment configuration?
Ans
A deployment configuration specifies how the behavior for how deployment should proceed, including how to handle deployment failure, through for a deployment group. You can use a deployment configuration to perform zero-downtime deployments to multi-instance deployment groups. For example, if your application needs at least 50% of the instances in a deployment group to be up and serving traffic, you can specify that in your deployment configuration so that a deployment does not cause downtime. 

Q8. What are the parameters that I need to specify for a deployment?
Ans
There are three parameters you specify for a deployment:
Revision - Specifies what to deploy.
Deployment group - Specifies where to deploy.
Deployment configuration - An optional parameter that specifies how to deploy.
Q9. What is an AppSpec file?
Ans
An AppSpec file is a configuration file that specifies the files to be copied and scripts to be executed. The AppSpec file uses the YAML format, and you include it in the root directory of your revision. The AppSpec file is used by the AWS CodeDeploy Agent and consists of two sections. The files section specifies the source files in your revision to be copied and the destination folder on each instance. The hooks section specifies the location (as relative paths starting from the root of the revision bundle) of the scripts to run during each phase of the deployment. Each phase of a deployment is called a deployment lifecycle event. 

Q10. What are deployment lifecycle events?
Ans

- ApplicationStop
You can use the ApplicationStop deployment lifecycle event if you want to gracefully stop the application or remove currently installed packages in preparation of a deployment.

- DownloadBundle
	During this deployment lifecycle event, the agent copies the revision files to a temporary location on the instance. This deployment lifecycle event is reserved for the agent and cannot be used to run user scripts.

- BeforeInstall
You can use the BeforeInstall deployment lifecycle event for preinstall tasks such as decrypting files and creating a backup of the current version.

- Install
	During this deployment lifecycle event, the agent copies the revision files from the temporary location to the final destination folder. This deployment lifecycle event is reserved for the agent and cannot be used to run user scripts

- AfterInstall
You can use the AfterInstall deployment lifecycle event for tasks such as configuring your application or changing file permissions.

- ApplicationStart
You typically use the ApplicationStart deployment lifecycle event to restart services that were stopped during ApplicationStop.

- ValidateService
ValidateService is the last deployment lifecycle event and is an opportunity to verify that the deployment completed successfully.

Q11. What are the typical steps to go through for deploying an application using AWS CodeDeploy?
Ans
Creating an application and deployment group (see the Concepts section for an explanation of these terms) are typically one-time setup tasks per application. The recurring actions are uploading a revision and deploying it.

Q12. What is AWS code pipeline?
Ans 
AWS CodePipeline is a continuous delivery service you can use to model, visualize, and automate the steps required to release your software. You can quickly model and configure the different stages of a software release process. CodePipeline automates the steps required to release your software changes continuously.