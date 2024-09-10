# Terraform Continuous Delivery

## Installation

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- [TFLint](https://github.com/terraform-linters/tflint#installation)
- [TFSec](https://aquasecurity.github.io/tfsec/v1.28.1/guides/installation/)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=powershell)

## SDLC

Visit the [FTDS Infrastructure](https://rockwellautomation.atlassian.net/wiki/spaces/R/pages/3052668628/FTDS+infrastructure) page in Confluence for a complete overview of the SDLC of Raider's infrastructure.

## Development

### Linting

We use [TFLint](https://github.com/terraform-linters/tflint#installation) to enfoce linting rules in our terraform code.

Run the following command to run tflint locally and verify your changes:

```bash
tflint --init
tflint --recursive --disable-rule terraform_typed_variables
```

The GitHub Action [./github/workflows/pr-lint.yaml](./.github/workflows/pr-lint.yaml) will run on every Pull Request to verify the linting rules. You must get a successful execution before merging your changes.

### Merge checklist

- No work-in-progress items.
- All technical debts (if any) have been captured as Jira tickets.
- Linting is passing.
- A PR was created with the new changes.
- The PR was approved by CodeOwners.
- All comments were resolved.
- An MR in `ra-ide-dist` was created to adopt the new version.
