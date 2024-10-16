# CI/CD For Application & Infrastructure

When it comes to DevOps, CI/CD is applicable for both application code and Infrastructure code (IaC).

We need to go through the testing and review process before we deploy the application code/Infra codes in an environment. 

For example, application code goes through unit testing, static code analysis, vulnerability scanning, etc. We need to follow the same for infrastructure code as well.

I have categorized the best practice under different titles. Let’s get right into it.

1. Config Management
Config management is an essential aspect of a CI/CD system.

For example, endpoints like Nexus URL, Sonarqube URL, vulnerability scanner endpoints, API endpoints, etc. 

Always make use of global variables for storing endpoints and common configs. If there is a change, all you have to do is change the global variable instead of making changes in each pipeline.

All the CI/CD tools support storing global variables and allow you to access the global variables in the pipeline.

2. Secret Management 
Uber has paid off hackers to hide a data breach that involved 57 million users.

Do you know how it happened?

Hackers got access to AWS credentials committed to the GitHub repository.

Every CI/CD system needs to deal with secrets. It could be API tokens, db credentials, cloud credentials, service account tokens, etc. You need to follow DevSecOps principles when dealing with secrets for CI/CD.

None of the secrets should be hard coded or stored in the ci system or git as plain text. Always use a secret management system where the CI/CD tool retrieves the required secrets in runtime. 

Secret management tools offer different mechanisms to access secrets in the runtime securely

Also, you need to ensure the secrets used by the pipelines do not appear in the logs.

Hashicorp Vault, AWS secrets manager, and Google secret manager are examples of external secret management solutions.

3. Follow DRY Principles
DRY – “Don’t Repeat Yourself”

From the beginning, you should work on minimizing CI/CD code duplications. A project might have so many pipelines with common steps.

One such example is a maven build. 

Assume you have 50 services that require maven build, and you duplicate the code for 50 pipelines. It’s not a scalable solution at all.

So it’s better to develop common libraries or workflows and reuse the steps in the pipelines instead of repeating them for every service. 

For example, Jenkins shared library, and GitHub Actions common workflows allow you to reuse the existing workflows for pipelines.

Note: Sometimes, developing common modules that fit all requirements is tricky. In these cases, you can extend the reusable modules to accommodate the specific project requirements.

4. Git PR Based Pipelines
We are in a GitOps era.

Every pipeline should be part of Git and tested for every PR.

Don’t manually create or trigger pipelines, at least during development. It causes inconsistencies and human error. For application and infra code, each PR should be automatically tested before getting committed to branches (Gated check-in).

Deploying to specific environments like staging or production might require manual intervention. This is primarily due to organizational policies, regulatory compliance, or the need for specific approval processes.

For example, a code change might need approvals from QA teams, performance teams, security teams, and business stakeholders before being deployed to a production environment.

5. Private Network Considerations
When we use CI/CD tools in an open network, we can access all the resources available online, and you can download and use it whenever required.

However, in real projects, CI/CD tools are set up in a private network behind forward proxies like Squid. You might need approval to download resources from the internet. This will be allowed only for official Linux repositories or dependency managers like Maven.

Most companies block public container registries like Docker Hub. So when you implement solutions, use private registries and official resources.

6. Developer-Centric Workflows: 
Create libraries and documents so anyone can onboard a new service without the knowledge of the tool. 

Some companies have platform teams who offer these generic templates as part of the InnerSource efforts.

And different teams in an organization contribute to the InnerSource to make it better.

7. Develop Pipelines for Team
Develop pipeline libraries that everyone in the team understands. Just because you can create a complex library doesn’t mean you have to. Always think from a team perspective.

For example, you can create a shared library using Jenkins pipeline DSL and pure Groovy code. If your DevOps team needs to gain a skillset to develop in Groovy, you should stick with DSL. Developing in pure Groovy would be an overhead for the team when a change is required.

8. Leverage Ephemeral Build Agents
Every CI/CD tool has the concept of build agents. To save cost and separation of concerns, it’s good to leverage ephemeral build agents. Meaning the agents get deployed only when needed.

You can call them dynamic agents or on-demand agents.

Every build would be running on an agent from a specific template, and it ensures consistency in the build environments.

The ephemeral agent could be a VM, Docker container, or even Kubernetes pod. Most CI/CD tools support ephemeral agents.

For example, you can integrate Jenkins with the Kubernetes cluster and configure jobs to spin up kubernetes pods as build agents.

GitHub actions by default support container-based agents or runners.