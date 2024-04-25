# Devops

DevOps is a work culture primarily centered around collaboration, communication, and integration among the development teams

What are the key benefits of using DevOps?

The key benefits of using DevOps include faster time-to-market, increased collaboration between teams, improved software quality and reliability, and efficient use of resources.



# What are the differences between Continuous Integration, Continuous Delivery, and Continuous Deployment?

Continuous Integration (CI) is a DevOps software development practice that permits developers to combine/merge the changes to their code in the central repository to run automated builds and tests

Continuous Delivery (CD) refers to the building, testing, and delivering improvements to the software code. The most critical part of the CD is that the code is always in a deployable stat

Continuous Deployment (CD) is the ultimate stage in the DevOps pipeline. It  refers to automatic release of any developer changes from the repository to the production stage.

Idempotency is the property that ensures that the results from an operation are the same, even if the same function is applied multiple times beyond the initial application. 

Agile prescribes working incrementally, collaboratively and flexibly; it does not prescribe a specific framework or methodology. A few of the most popular frameworks that Agile teams adopt are Scrum, Kanban and Extreme Programming. Teams may choose one of these frameworks or pieces of each.
## ADVANTAGES CLOUD COMPUTING

- trade capital expenses for variable expenses
- benefits from massive economic of scale
- stop guessing capacity
- increase speed and agility
- go global in minutes

## RTO and RPO
 Recovery time objective (RTO): The maximum acceptable delay between the interruption of service and restoration of service. This determines an acceptable length of time for service downtime.
Recovery point objective (RPO): The maximum acceptable amount of time since the last data recovery point. This determines what is considered an acceptable loss of data.

# branch stategy 

# branch stategy 


## GIT FLOW
In the Git flow development model, you have one main development branch with strict access to it. It’s often called the develop branch.

Developers create feature branches from this main branch and work on them. Once they are done, they create pull requests. In pull requests, other developers comment on changes and may have discussions, often quite lengthy ones

**Overview:** Utilizes two main branches: master for production-ready code and develop for ongoing development. Feature branches, release branches, and hotfix branches are used for specific tasks.

**Advantages:**

- Structured Release Management: Provides a structured approach to release management, with dedicated branches for features, releases, and hotfixes.
- Stability: Keeps the master branch stable, as it only contains production-ready code, while ongoing development occurs in the develop branch.
- Parallel Development: Allows for parallel development of features and hotfixes, ensuring that ongoing development is not blocked by release activities.

**Disadvantages:**
- Complexity: The Gitflow model can be relatively complex, especially for smaller teams or projects, requiring discipline and adherence to the workflow.

- Overhead: Managing multiple long-lived branches (e.g., feature, release, hotfix) can introduce overhead and administrative burden, potentially slowing down development.



## Trunk-based Development Workflow

**Overview:** All development occurs directly on the main branch (master or main). Developers use feature toggles, feature flags, or experimental branches to isolate incomplete or experimental features.

**Advantages:** Promotes continuous integration and rapid feedback cycles, reduces merge conflicts, and encourages small, frequent commits.


- Simplicity: Trunk-based development simplifies the branching model by having all development occur directly on the main branch (often master or main). This simplicity can reduce overhead and streamline the development process, especially for small teams or projects.

- Continuous Integration: Trunk-based development promotes continuous integration practices, where developers frequently merge their changes into the main branch. This ensures that code changes are regularly integrated, tested, and validated, leading to fewer integration issues and faster feedback cycles.

- Reduced Merge Conflicts: With developers working directly on the main branch, there are fewer long-lived feature branches, reducing the likelihood of merge conflicts. Developers are encouraged to make small, incremental changes, minimizing the impact of conflicts and making them easier to resolve.

- Faster Feedback: Trunk-based development encourages rapid feedback cycles, as changes are integrated into the main branch and tested promptly. This enables developers to identify issues early and address them quickly, improving overall code quality and stability.

- Encourages Collaboration: Since all development occurs on the main branch, developers have visibility into each other's changes and can collaborate more effectively. Code reviews, discussions, and feedback are integral parts of the development process, fostering collaboration and knowledge sharing within the team.

**Disadvantages:**

- Risk of Instability: Working directly on the main branch can introduce instability, especially if developers introduce bugs or incomplete features. Since changes are immediately reflected in the main branch, there is a risk of disrupting other developers' work or impacting the stability of the codebase.

- Limited Experimentation: Trunk-based development may discourage experimentation or exploration of new ideas, as changes are immediately integrated into the main branch. Developers may feel pressured to prioritize stability over innovation, potentially stifling creativity and innovation.

- Dependency Management: Trunk-based development relies heavily on feature toggles or experimental branches to isolate incomplete or experimental features. Managing these toggles or branches effectively requires careful coordination and communication among team members, adding complexity to the development process.

- High Level of Discipline: Trunk-based development requires a high level of discipline and adherence to best practices such as continuous integration, automated testing, and small, incremental changes. Without proper discipline, the main branch can quickly become unstable, leading to integration issues and delays.

**Example:** Developers work directly on the main branch, using feature toggles or experimental branches to isolate incomplete features until they are ready for release.

## Feature Branch:

**Overview:** Each new feature or task is developed in its own branch, typically branched off the main development branch (e.g., master or develop).

**Advantages:**

- Isolation: Each feature or task is developed in its own branch, allowing for isolation of changes and preventing interference with other features.
- Collaboration: Facilitates collaborative development by enabling team members to work on different features simultaneously without conflicts.
- Code Review: Pull requests can be used for code review, providing an opportunity for feedback and ensuring quality before merging.

**Disadvantages:**

- Branch Proliferation: If not managed properly, the repository can become cluttered with numerous feature branches, making it challenging to track and manage.
- Integration Complexity: Merging feature branches back into the main branch (e.g., master or develop) can sometimes result in merge conflicts or integration issues.

Example: GitHub Flow, where feature branches are created for each new feature, and pull requests are used for code review and merging.


# Containerization
Containerization is a software deployment process that bundles an application’s code with all the files and libraries it needs to run on any infrastructure.

A container is a standard unit of software bundled with dependencies so that applications can be deployed fast and reliably b/w different computing platforms.

## Containerization compared to virtual machines
Containerization is a similar but improved concept of a VM. Instead of copying the hardware layer, containerization removes the operating system layer from the self-contained environment. This allows the application to run independently from the host operating system. Containerization prevents resource waste because applications are provided with the exact resources they need. 
