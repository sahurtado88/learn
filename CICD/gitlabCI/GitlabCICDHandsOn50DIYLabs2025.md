## Register gitlabrunner

## setup docker

## gitlab runner concurrent limit

##  Gitlab pipelines

In GitLab CI, pipelines serve as the overarching structure for continuous integration and
continuous delivery (CI/CD) processes.

Pipelines consist of two key components:

- Jobs: These define the specific tasks to be performed, specifying what needs to be done.
- Stages: Stages determine when jobs should run and provide instructions on how they
should be executed.

GitLab runners are responsible for executing these jobs. Multiple jobs within the same stage
can run concurrently, depending on the available concurrent runners.

The progression of the pipeline is contingent on the success of jobs within each stage. If all
jobs in a particular stage succeed, the pipeline advances to the next stage.
However, if any job in a stage fails, the subsequent stage will not be executed, and the pipeline
will be halted at that point. This ensures that further stages are only attempted when the
preceding ones have been successfully completed.

# GitlabCI Stages

- Definition: Stages in GitLab CI determine when to execute jobs and provide a structured approach
to the CI/CD pipeline.
- Purposeful Division: Stages categorize jobs based on their roles, such as building, testing,
scanning, and deploying.
- Execution Control: Stages dictate the order in which jobs run, establishing a logical flow in the
CI/CD process.
- Modular Structure: Different stages cater to specific sections, allowing customization of the
pipeline for diverse project needs.
- Zero, One, or Multiple Jobs: Stages can include varying numbers of jobs, providing flexibility in
pipeline design.
- Parallel Execution: All jobs within a stage run simultaneously, optimizing the overall pipeline
efficiency.
- Common Stages:
    - Build: Compiles code and generates artifacts.
    - Test: Runs tests to ensure code quality and functionality.
    - Scan: Conducts security and vulnerability scans.
    - Deploy: Transfers the application to specified environments.


# Stage vs Stages

- GitLab CI Stage: Represents a specific point in the CI/CD pipeline, defining
when to execute related jobs. It acts as a singular milestone, ensuring
orderly progression through the pipeline.

- GitLab CI Stages: Refers to the collective divisions within the CI/CD pipeline.
These stages categorize jobs based on functionality (e.g., build, test,
deploy), allowing for a structured and modular organisation of the continuous
integration and deployment process.

# Default Stages

In GitLab, the Default pipeline stages are:
.pre
build
test
deploy
.post

.pre -> will always be the first stage, we cannot change it.
.post -> will always be the last stage, we cannot change it as well.
builds, test & deploy -> these stages sequence we can change