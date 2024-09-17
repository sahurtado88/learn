# Argo CD

# what is Gitops

- A set of practices that leverages Git as the single source of truth for declarative infraestructure and application configurations
- Enables teams to streamline their application delivery process, automate deployments, and improve collaboration

# Core principals of Gitops

- Declarative configuration
- Version Control
- Automated synchronization
- Continous feedback

# benefits of Gitops

- Increased productivity
- Improved collaboration
- Enhanced Security
- Faster recovery

# what is Argo Cd

- a declarative. gitops continous delivery tool for kubernetes
- using Git as the single source of truth
- Can manage multiple kubernetes environments

# Key features of ArgoCd

- Declarative and versioned
- multicluster support
- Automated Sync and rollbacks
- plugable deployment strategies
- extensibility

# Argo CD architecture

## Argo CD API server

The API server is a gRPC/REST server which exposes the API consumed by the Web UI, CLI, and CI/CD systems. It has the following responsibilities:

- application management and status reporting
- invoking of application operations (e.g. sync, rollback, user-defined actions)
- repository and cluster credential management (stored as K8s secrets)
- authentication and auth delegation to external identity providers
- RBAC enforcement
- listener/forwarder for Git webhook events

## Respository Server

The repository server is an internal service which maintains a local cache of the Git repository holding the application manifests. It is responsible for generating and returning the Kubernetes manifests when provided the following inputs:

- repository URL
- revision (commit, tag, branch)
- application path
- template specific settings: parameters, helm values.yaml

## Application Controller
The application controller is a Kubernetes controller which continuously monitors running applications and compares the current, live state against the desired target state (as specified in the repo). It detects OutOfSync application state and optionally takes corrective action. It is responsible for invoking any user-defined hooks for lifecycle events (PreSync, Sync, PostSync)

## Argo CD Server

This is the core component of Argo CD. It runs as a  Kubernetes deployment and acts as the control plane for managing the continuous delivery workflow. It handles the synchronization of the actual state with the desired state defined in Git.

https://argo-cd.readthedocs.io/en/stable/operator-manual/architecture/

- Argo CD CLI

# Advantages of ArgoCD

- streamlined Deployments
- Enhanced Collaboration
- Improved security
- Faster incident response
- Scalability

# Why Gitops with ArgoCD ?

- kubernetes-native
- provides automated deployments
- support various configuration managment tools
- Enhances security and compliance
- Facilitates collaboration and transparency


# Setting up Environment

## GIT

Run:
```
sudo apt update
sudo apt install git -y
git --version
```
Configure the git user information by running:
```
git config --global user.name "your name"
git config --global user.email "your@email.com"
git config --global core.editor "vim" # execute
```
Create an SSH key-pair:
```
ssh-keygen -t ed25519 -C "your@email"
eval "$(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
# Copy the contents of the key
```
- Navigate to Gitlab.com

- Login using SSO.

- Click on the profile icon.

- Choose preferences.

- Choose SSH keys from the left-hand navigation.

- Paste the contents of the public key in the box.

- Click add key.

## Install Kind

Install Docker by running the following commands:
```
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker ${USER}
newgrp docker
docker version
```
- Navigate to https://www.docker.com/products/docker-desktop/ and show that you can install Docker Desktop for Windows or macOS.

- Install kubectl by runnig the following command:
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mv kubectl /usr/local/bin
sudo chmod +x /usr/local/bin/kubectl
kubectl version --client
```
- Go to https://github.com/kubernetes-sigs/kind/releases

- Scroll down till you find the downloadable files.

- Right click on the Linux AMD64 and copy the link.

- In the terminal, run the following:
```
wget https://github.com/kubernetes-sigs/kind/releases/download/v0.18.0/kind-linux-amd64
sudo mv kind-linux-amd64 /usr/local/bin/kind
sudo chmod +x /usr/local/bin/kind
kind version
kind create cluster # don't run this command yet
```

Create a cluster configuration file as follows:
```
# cluster.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
```

- Create a cluster by running the following command:
```
kind create cluster --config=cluster.yaml
kubectl cluster-info --context kind-kind
```
- Run the following commands to deploy an ingress controller:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
```

### KIND Windows

First, install Docker for windows. Steps to Install are here. Video tutorial is here.

Then install Kubectl for windows by following this.

Once that’s done. Install Kind from PowerShell. Run the following command.
```
curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64
Move-Item .\kind-windows-amd64.exe C:\Kind\kind.exe
```

On windows find for “Advanced system settings” > Click on “Environment Variables” under “System Variables” set new “Path” variable to D:\Kind

Note, you can change the location from D:\Kind\kind.exe to whatever you like.

More useful information https://kind.sigs.k8s.io/docs/user/quick-start/#installation. 

Follow this video guide.
https://youtu.be/IyauUBMe2ds

## Install argocd

Install Helm:
```
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
Install Argo CD on the cluster using Helm as follows:
```
helm repo add argo https://argoproj.github.io/argo-helm
kubectl create namespace argocd
helm install argocd -n argocd argo/argo-cd
```
Get the administrator password (or just copy the command from the Helm output):
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
- Copy the password that was brought.

- Create a port-forward to access the UI of the server by running:
```
kubectl port-forward service/argocd-server -n argocd 8080:443 --address="0.0.0.0"
```
- Open the browser and navigate to 192.168.2.30:8080. Accept the security risk. Enter the username: admin and paste the password from the above output.

- Return back to the terminal and install the Nginx ingress controller by running the following command:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
```
- Retun the Helm command enabling Ingress and the other required options:
```
helm upgrade argocd --set configs.params."server\.insecure"=true --set server.ingress.enabled=true  --set server.ingress.ingressClassName="nginx" -n argocd argo/argo-cd
```

# Git repository structure best practice

- Use a single repository per application or environment
- use branches to manage different stages of the development and deployment process
- Store configuration data in a separate directory from application code
- Use descriptive names for directories and files
- Use git submodules to manage shared configuration

# Manifest, Helm Charts and kustomize

## Manifest
### PRO
- simple and easy to understand
- provide clear and complete picture of the desired state of a kubernetes objects
- can be customized to meet specific requirements

### CONS
- can become cumbersome to manage
- require manual updates when changes are made
- difficult to reuse across different environments
- Managing secrets in manifest can be a security risk

## HELM
### PRO
- helm provide a way to package, distribute and manage Kubernetes applications as a single unit
- Allow for parameterization , so you can reuse a char with different values based on your environment

### CONS
- They can be complex to create and manage
- they can introduce risk to your deployment pipelines

## KUSTOMIZE
### PRO
- Allow you to customize your kubernetes object without modifying the original YAML files
- Provides a way to manage complex configurations and apply multiple customizations in a predictable and repeatable manner
### CONS
- Can be complex to create and manage, especially for complex configurations
- Requieres an understanding of YAML and kubernetes resources, as well as a familiarity with Kustomize configuration files and patches

# Gitops best practice

- use version control for all your infraestructure code
- Follow a pull-based model fro deployments
- Ensure that all cahnges are auditable and traceable
- Automate as much as possible
- Ensure that all configurations are tested and validated before deployment
- implemnet security best practices

# ARGO CD best practices

- Use git as the source of truth for the configuration and deployment information
- Use a version control system for the git repository
- Use kubernetes namespaces to organize and manage the resources in the cluster
- Use kubernetes RBAC to control access to the resources in the cluster
- Use helm charts or Kustomize to manage the deployment of complex applications
