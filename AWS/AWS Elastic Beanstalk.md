# Elastic Beanstalk – Overview
• Elastic Beanstalk is a developer centric view of deploying an application
on AWS
• It uses all the component’s we’ve seen before: EC2, ASG, ELB, RDS, …
• Managed service
    • Automatically handles capacity provisioning, load balancing, scaling, application
    health monitoring, instance configuration, …
    • Just the application code is the responsibility of the developer
• We still have full control over the configuration
• Beanstalk is free but you pay for the underlying instances

# Elastic Beanstalk – Components
• Application: collection of Elastic Beanstalk components (environments,
versions, configurations, …)
• Application Version: an iteration of your application code
• Environment
    • Collection of AWS resources running an application version (only one application
    version at a time)
    • Tiers: Web Server Environment Tier & Worker Environment Tier
    • You can create multiple environments (dev, test, prod, …)