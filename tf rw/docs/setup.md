# Setup

## Harness Github Connector Configuration

### Generate ssh keys

```shell
ssh-keygen -t ecdsa -b 256 -f /<PATH>/ecdsa_github_terraform_cd -m pem
```

### Github

- Add deploy key `https://github.com/Rockwell-Automation-FTDS/terraform-cd/settings/keys`
- Name: `harness-connector-terraform-cd`
- Copy ecdsa_github_terraform_cd.pub

### Harness

[+]Add Git Connector

- Display Name: `github-ftds-terraform-cd-main`
- Provider: `Git`
- SSH / url: `github.com:Rockwell-Automation-FTDS/terraform-cd.git`
- Username: `git` 

[+] Add SSH configuration

- Display Name: `github-ftds-terraform-cd-ssh`
- User Name: `git`

[+] Create Encrypted file

- Name: `github-ftds-terraform-cd-ssh-key`
- File: `/<PATH>/ecdsa_github_terraform_cd`

[+] Back Git Connector

- Branch Name: `main`