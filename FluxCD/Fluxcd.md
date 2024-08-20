# FLUXCD

Flux is a tool for keeping Kubernetes clusters in sync with sources of configuration (like Git repositories), and automating updates to configuration when there is new code to deploy.

Flux is built from the ground up to use Kubernetes' API extension system, and to integrate with Prometheus and other core components of the Kubernetes ecosystem. Flux supports multi-tenancy and support for syncing an arbitrary number of Git repositories.

## FluxCD Features

- Automated Deployments
- Multi- tenancy
- Integration with git providers (gitlba, ithub, bitbucket)

## FluxCD Architecture

Flux operator
helm operator
kustomization Operator

## Conect git with your git repo

ssh-keygen -t ed25519 -C "cualquiercosa@com"
This creates a new SSH key, using the provided email as a label.

```
> Generating public/private ALGORITHM key pair.
```

When you're prompted to "Enter a file in which to save the key", you can press Enter to accept the default file location.

At the prompt, type a secure passphrase. 
```
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```

- Adding your SSH key to the ssh-agent

in linux

```
eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519

```

in windows

In a new admin elevated PowerShell window, ensure the ssh-agent is running.
```
# start the ssh-agent in the background
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent

# In a terminal window without elevated permissions, add your SSH private key to the ssh-agent. # If you created your key with a different name, or if you are adding an existing key that has # a different name, replace id_ed25519 in the command with the name of your private key file.
ssh-add c:/Users/YOU/.ssh/id_ed25519
```

Add the SSH public key to your account on GitHub. or gitlab

## Setting up a Kubernetes cluster for fluxCD

Follow resources.pdf instructions


## Installing the Ingress controller on KinD
In the previous lecture, we configured our KinD cluster to use the Nginx Ingress controller and, thus, create Ingress objects when needed.

To deploy the Nginx Ingress Controller, you need to run the following command from the terminal while your KUBECONFIG variable is pointing to it (if you followed the steps in the previous lecture, then you're good to go):
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
```
For more information about how to deploy and work with other types of Ingress Controllers with KinD and how the Nginx Ingress Controller works, you can refer to this link https://kind.sigs.k8s.io/docs/user/ingress/

## Install FLUXCD

follow instruction in Resource installFluXCD.pdf 

to instlal home brew in linux use thsi command

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

# Syncing Kubernetes resources with Flux CD


