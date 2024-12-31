# GitOps
GitOps is a way of managing your infrastructure and applications so that whole system is described declaratively and version controlled (most likely in a Git repository), and having an automated process that ensures that the deployed environment matches the state specified in a repository.

# GitOps Principles

1. Declarative
A system managed by GitOps must have its desired state expressed declaratively.


2. Versioned and Immutable
Desired state is stored in a way that enforces immutability, versioning and retains a complete version history.


3. Pulled Automatically
Software agents automatically pull the desired state declarations from the source.


4. Continuously Reconciled
Software agents continuously observe actual system state and attempt to apply the desired state.