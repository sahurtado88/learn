# Azure Devops


Key concepts overview

key concepts graphic

A trigger tells a pipeline to run.
A pipeline is made up of one or more stages. A pipeline can deploy to one or more environments.
A stage is a way of organizing jobs in a pipeline and each stage can have one or more jobs.
Each job runs on one agent. A job can also be agentless.
Each agent runs a job that contains one or more steps.
A step can be a task or script and is the smallest building block of a pipeline.
A task is a prepackaged script that performs an action, such as invoking a REST API or publishing a build artifact.
An artifact is a collection of files or packages published by a run.

https://learn.microsoft.com/en-us/azure/devops/pipelines/get-started/key-pipelines-concepts?view=azure-devops

## Stages, jobs and steps

job is a collection of multiple task and stages is a collection of multiple jobs

```
- job: string  # name of the job, A-Z, a-z, 0-9, and underscore
  displayName: string  # friendly name to display in the UI
  dependsOn: string | [ string ]
  condition: string
  strategy:
    parallel: # parallel strategy
    matrix: # matrix strategy
    maxParallel: number # maximum number simultaneous matrix legs to run
    # note: `parallel` and `matrix` are mutually exclusive
    # you may specify one or the other; including both is an error
    # `maxParallel` is only valid with `matrix`
  continueOnError: boolean  # 'true' if future jobs should run even if this job fails; defaults to 'false'
  pool: pool # agent pool
  workspace:
    clean: outputs | resources | all # what to clean up before the job runs
  container: containerReference # container to run this job inside
  timeoutInMinutes: number # how long to run the job before automatically cancelling
  cancelTimeoutInMinutes: number # how much time to give 'run always even if cancelled tasks' before killing them
  variables: { string: string } | [ variable | variableReference ] 
  steps: [ script | bash | pwsh | powershell | checkout | task | templateReference ]
  services: { string: string | container } # container resources to run as a service container
  uses: # Any resources (repos or pools) required by this job that are not already referenced
    repositories: [ string ] # Repository references to Azure Git repositories
    pools: [ string ] # Pool names, typically when using a matrix strategy for the job
```