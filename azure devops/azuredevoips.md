# Azure devops

A task is a pre-packaged script. You can use tasks for building, testing, publishing, or deploying your app. For Java, the Maven task we used handles testing and publishing results, however, you can use a task to publish code coverage results too.

## Build across multiple platforms
You can build and test your project on multiple platforms. One way to do it is with strategy and matrix. You can use variables to conveniently put data into various parts of a pipeline. For this example, we'll use a variable to pass in the name of the image we want to use.

```
strategy:
  matrix:
    linux:
      imageName: "ubuntu-latest"
    mac:
      imageName: "macOS-latest"
    windows:
      imageName: "windows-latest"
  maxParallel: 3

pool:
  vmImage: $(imageName)
```

Each agent can run only one job at a time. To run multiple jobs in parallel you must configure multiple agents. You also need sufficient parallel jobs.

## Build using multiple versions
To build a project using different versions of that language, you can use a matrix of versions and a variable. In this step, you can either build the Java project with two different versions of Java on a single platform or run different versions of Java on different platforms.

You cannot use strategy multiples times in a context.

```
strategy:
  matrix:
    jdk10:
      jdkVersion: "1.10"
    jdk11:
      jdkVersion: "1.11"
  maxParallel: 2
```

```
trigger:
- main

strategy:
  matrix:
    jdk10_linux:
      imageName: "ubuntu-latest"
      jdkVersion: "1.10"
    jdk11_windows:
      imageName: "windows-latest"
      jdkVersion: "1.11"
  maxParallel: 2

pool:
  vmImage: $(imageName)

steps:
- task: Maven@4
  inputs:
    mavenPomFile: "pom.xml"
    mavenOptions: "-Xmx3072m"
    javaHomeOption: "JDKVersion"
    jdkVersionOption: $(jdkVersion)
    jdkArchitectureOption: "x64"
    publishJUnitResults: true
    testResultsFiles: "**/TEST-*.xml"
    goals: "package"
```

## Customize CI triggers
Pipeline triggers cause a pipeline to run. You can use trigger: to cause a pipeline to run whenever you push an update to a branch. YAML pipelines are configured by default with a CI trigger on your default branch (which is usually main). You can set up triggers for specific branches or for pull request validation. For a pull request validation trigger, just replace the trigger: step with pr: as shown in the two examples below. By default, the pipeline runs for each pull request change.

```
trigger:
  - main
  - releases/*
```

```
pr:
  - main
  - releases/*
```

## Create work item on failure

The following example has two jobs. The first job represents the work of the pipeline, but if it fails, the second job runs, and creates a bug in the same project as the pipeline.
```
# When manually running the pipeline, you can select whether it
# succeeds or fails.
parameters:
- name: succeed
  displayName: Succeed or fail
  type: boolean
  default: false

trigger:
- main

pool:
  vmImage: ubuntu-latest

jobs:
- job: Work
  steps:
  - script: echo Hello, world!
    displayName: 'Run a one-line script'

  # This malformed command causes the job to fail
  # Only run this command if the succeed variable is set to false
  - script: git clone malformed input
    condition: eq(${{ parameters.succeed }}, false)

# This job creates a work item, and only runs if the previous job failed
- job: ErrorHandler
  dependsOn: Work
  condition: failed()
  steps: 
  - bash: |
      az boards work-item create \
        --title "Build $(build.buildNumber) failed" \
        --type bug \
        --org $(System.TeamFoundationCollectionUri) \
        --project $(System.TeamProject)
    env: 
      AZURE_DEVOPS_EXT_PAT: $(System.AccessToken)
    displayName: 'Create work item on failure'
```

## Key concepts

- A trigger tells a pipeline to run.
- A pipeline is made up of one or more stages. A pipeline can deploy to one or more environments.
- A stage is a way of organizing jobs in a pipeline and each stage can have one or more jobs.
- Each job runs on one agent. A job can also be agentless.
- Each agent runs a job that contains one or more steps.
- A step can be a task or script and is the smallest building block of a pipeline.
- A task is a prepackaged script that performs an action, such as invoking a REST API or publishing a build artifact.
- An artifact is a collection of files or packages published by a run.

## Azure Pipelines terms

### Agent
When your build or deployment runs, the system begins one or more jobs. An agent is computing infrastructure with installed agent software that runs one job at a time. For example, your job could run on a Microsoft-hosted Ubuntu agent.

### Approvals
Approvals define a set of validations required before a deployment runs. Manual approval is a common check performed to control deployments to production environments. When checks are configured on an environment, a pipeline run pauses until all the checks are completed successfully.

### Artifact
An artifact is a collection of files or packages published by a run. Artifacts are made available to subsequent tasks, such as distribution or deployment. For more information, see Artifacts in Azure Pipelines.

### Continuous delivery
Continuous delivery (CD) is a process by which code is built, tested, and deployed to one or more test and production stages. Deploying and testing in multiple stages helps drive quality. Continuous integration systems produce deployable artifacts, which include infrastructure and apps. Automated release pipelines consume these artifacts to release new versions and fixes to existing systems. Monitoring and alerting systems run constantly to drive visibility into the entire CD process. This process ensures that errors are caught often and early.

### Continuous integration
Continuous integration (CI) is the practice used by development teams to simplify the testing and building of code. CI helps to catch bugs or problems early in the development cycle, which makes them easier and faster to fix. Automated tests and builds are run as part of the CI process. The process can run on a set schedule, whenever code is pushed, or both. Items known as artifacts are produced from CI systems. They're used by the continuous delivery release pipelines to drive automatic deployments.

### Deployment
A classic pipeline deployment is the action of running the tasks for one stage. The deployment can include running automated tests, deploying build artifacts, and any other actions are specified for that stage.

For YAML pipelines, a deployment refers to a deployment job. A deployment job is a collection of steps that are run sequentially against an environment. You can use strategies like run once, rolling, and canary for deployment jobs.

### Deployment group
A deployment group is a set of deployment target machines that have agents installed. A deployment group is just another grouping of agents, like an agent pool. You can set the deployment targets in a pipeline for a job using a deployment group. 

## Environment
An environment is a collection of resources where you deploy your application. One environment can contain one or more virtual machines, containers, web apps, or any service. Pipelines deploy to one or more environments after a build is completed and tests are run.

### Job
A stage contains one or more jobs. Each job runs on an agent. A job represents an execution boundary of a set of steps. All of the steps run together on the same agent. Jobs are most useful when you want to run a series of steps in different environments. For example, you might want to build two configurations - x86 and x64. In this case, you have one stage and two jobs. One job would be for x86 and the other job would be for x64.

Agentless jobs run in Azure DevOps and Azure DevOps Server without using an agent. A limited number of tasks support agentless jobs.

### Pipeline
A pipeline defines the continuous integration and deployment process for your app. It's made up of one or more stages. It can be thought of as a workflow that defines how your test, build, and deployment steps are run.

For classic pipelines, a pipeline can also be referred to as a definition.

### Release
For classic pipelines, a release is a versioned set of artifacts specified in a pipeline. The release includes a snapshot of all the information required to carry out all the tasks and actions in the release pipeline, such as stages, tasks, policies such as triggers and approvers, and deployment options. You can create a release manually, with a deployment trigger, or with the REST API.

For YAML pipelines, the build and release stages are in one, multi-stage pipeline.

### Run
A run represents one execution of a pipeline. It collects the logs associated with running the steps and the results of running tests. During a run, Azure Pipelines will first process the pipeline and then send the run to one or more agents. Each agent runs jobs. Learn more about the pipeline run sequence.

For classic pipelines, a build represents one execution of a pipeline.

### Script
A script runs code as a step in your pipeline using command line, PowerShell, or Bash. You can write cross-platform scripts for macOS, Linux, and Windows. Unlike a task, a script is custom code that is specific to your pipeline.

### Stage
A stage is a logical boundary in the pipeline. It can be used to mark separation of concerns (for example, Build, QA, and production). Each stage contains one or more jobs. When you define multiple stages in a pipeline, by default, they run one after the other. You can specify the conditions for when a stage runs. When you're thinking about whether you need a stage, ask yourself:

- Do separate groups manage different parts of this pipeline? For example, you could have a test manager that manages the jobs that relate to testing and a different manager that manages jobs related to production deployment. In this case, it makes sense to have separate stages for testing and production.
- Is there a set of approvals that are connected to a specific job or set of jobs? If so, you can use stages to break your jobs into logical groups that require approvals.
- Are there jobs that need to run a long time? If a job in your pipeline has a long run time, it makes sense to put that job in its own stage.

### Step
A step is the smallest building block of a pipeline. For example, a pipeline might consist of build and test steps. A step can either be a script or a task. A task is simply a precreated script offered as a convenience to you. To view the available tasks, see the Build and release tasks reference. For information on creating custom tasks, see Create a custom task.

### Task
A task is the building block for defining automation in a pipeline. A task is packaged script or procedure that has been abstracted with a set of inputs.

### Trigger
A trigger is something that's set up to tell the pipeline when to run. You can configure a pipeline to run upon a push to a repository, at scheduled times, or upon the completion of another build. All of these actions are known as triggers. For more information, see build triggers and release triggers.

### Library
The Library includes secure files and variable groups. Secure files are a way to store files and share them across pipelines. For example, you may want to reference the same file for different pipelines. In that case, you can save the file within Library and use it when you need it. Variable groups store values and secrets that you might want to be passed into a YAML pipeline or make available across multiple pipelines.