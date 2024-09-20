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

# Deployin a sample application to ArgocD (manifest)

- This lecture assumes that you are using GitLab. For other Git services, please consult the provider's documentation.
- Go to gitlab.com and login.
- Create a new project called SampleGitOpsApp. The project should be blank, private, and without a README file.* Go back to the terminal and run the following commands:
```
cd myapp
git remote add origin git@gitlab.com:[your username]/samplegitopsapp.git
git push -u origin --all
```
- Go back to Gitlab and refresh the page.
- Click on the profile picture and select preferences. Select peronsl access tokens.
- Create one called argo cd. The access level should be api .
- Copy the value of the token.
- On the terminal, create a secret by running the following command:
```
argocd repo add "https://gitlab.com/abohmeed/samplegitopsapp.git" --username "
[your username]" --password "[your personal token]"
```
- Create the Argo CD directory by running the following commands:
```
mkdir argo-cd
cd argo-cd
```
- Create the Nginx installation file as follows:
```
# nginx.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
    name: nginx
    namespace: argocd
spec:
    project: default
    source:
        repoURL: 'https://gitlab.com/[your username]/samplegitopsapp.git'
        path: manifests
        targetRevision: main
    destination:
        server: 'https://kubernetes.default.svc'
        namespace: default
    syncPolicy:
    automated:
        selfHeal: true
        prune: true
```
- Apply the manifest to the cluster as follows:
```
kubectl apply -f nginx.yaml
```
- Go to the UI and view the applications. Make sure that the sync status is OK. Go back to the terminal and view the running pods and services:
```
kubectl get pods
kubectl get services
```
- Create a Git workflow as follows:
```
git checkout -b feature/increase-replicas
# modify the deployment replicas to be three
git add base/deployment.yaml
git commit -m "Inreases the replica count"
git push --set-upstream origin feature/increase-replicas
```

- Go to Gitlab by copying the link from the output message of the above command. Approve and merge the MR. Go back to the terminal and run the following:
```
argocd app sync nginx
kubectl get pods
```
# Deploying a sample application to ArgocD (HELM)

1. Create a new YAML file called argocd.yaml and add the following:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: argocd
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://gitlab.com/[your username]/samplegitopsapp.git'
    path: argo-cd
    targetRevision: main
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: argocd
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
```

2. Apply the above configuration by running:
```
kubectl apply -f argocd.yaml
```

3. Go to the UI of Argo CD.

4. Login using the username of admin and your password

5. Delete the nginx application from the UI. You need to type the name of the application nginx in the dialog box for the deletion operation to complete.

6. Go to the terminal and in the argocd directory create a new application manifest for HTTPbin. The filename should be httpbin.yaml and the contents should be as follows:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: httpbin
  namespace: argocd
spec:
  project: default
  source:
    chart: httpbin
    repoURL: https://matheusfm.dev/charts
    targetRevision: 0.1.1
    helm:
      releaseName: httpbin
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
```
7. Create and push a merge request:
```
git checkout -b feature/add-httpbin-chart
git add httpbin.yaml
git commit -m "Adds the HTTPbin chart"
git push --set-upstream origin feature/add-httpbin-chart
```
8. Copy the MR link that is displayed and paste it in new browser tab.

9. Approve and merge the MR.

10. Go to ArgoCD UI and click Refresh on the argocd application. You should see the HTTPbin application appear and the icon reflecting that it is a Helm chart.

11. Go back to the terminal and open the httpbin.yaml.

12. The contents of the file should look as follows:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: httpbin
  namespace: argocd
spec:
  project: default
  source:
    chart: httpbin
    repoURL: https://matheusfm.dev/charts
    targetRevision: 0.1.1
    helm:
      releaseName: httpbin
      values: |
        service:
          type: NodePort
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
```
13. Save the file.

14. Create a merge request by running the following commands:
```
git checkout -b feature/httpbin-service-type
git add httpbin.yaml
git checkout -m "Changes the HTTPbin service type to NodePort"
git push --set-upstream origin feature/httpbin-service-type
```
15. Copy the link from the output and paste it in a new browser tab. Create, approve, and merge the MR.

16. Move to the Argo CD dashboard and refresh the argocd application.

17. Move back to the terminal and check the service type again by running:
```
kubectl get svc
```
18. Type the following command (without executing it):
```
helm upgrade httpbin --set service.type=nodeport matheusfm/httpbin
```
19. Get the node IP address by running:
```
kubectl get nodes -o wide
```
20. Test the service by running:
```
curl "172.18.0.2:31994/get" -H "accept: application/json" # replace the IP address and port with the appropriate values.
```
21. Create a new Helm chart in the root directory by running the following command:
```
helm create httpd
```
23. Go inside the directory and change the values file as follows:
```
# values.yaml
image:
  repository: httpd
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: latest
```
24. Check the version of the chart in the Chart.yaml file.

25. Package the chart by running:
```
helm package .
```
26. Check the file that was created by running:
```
ls -ltr
```
27. Get the project ID from Gitlab by going to the project page and clicking on settings. Copy the ID.

28. In the terminal, upload the package by running the following command:
```
curl --request POST --form 'chart=@httpd-0.1.0.tgz' --user "[your username]:[your token]" https://gitlab.com/api/v4/projects/[your project id]/packages/helm/api/stable/charts
```
29. Create the repository credentials using the following command:
```
argocd repocreds add https://gitlab.com/api/v4/projects/[your project id]/packages/helm/stable --username [your username] --password [your personal token]
```
30. Create a new branch to add the  manifest:
```
git checkout -b feature/httpd
```
31. Create a new application in the argocd directory called busybox.yaml and add the following content:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: httpd
  namespace: argocd
spec:
  project: default
  source:
    chart: httpd
    repoURL: https://gitlab.com/api/v4/projects/[project id]/packages/helm/stable
    targetRevision: 0.1.0
    helm:
      releaseName: httpd
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
```

32. Push the changes to Gitlab
```
git add -A
git commit -m "Adds the Apache Argo CD manifest"
git push --set-upstream origin feature/httpd
```
33. Copy the link that was generated in the output, paste in a new browser tab. Approve and merge the MR to the main branch.

34. Move to the Argo CD UI and click on the Refresh button on the Argo CD applciation to sync the changes.

35. Move to the terminal and view the BusyBox pods by running:
```
kubectl get pods
```
36. Create a new branch to change Nginx installation method from manifests to the Helm directory:
```
git checkout -b feature/nginx-helm
```
37. Change the nginx.yaml manifest to look as follows:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: nginx
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://gitlab.com/[your username]/samplegitopsapp.git'
    path: mychart # changed
    targetRevision: main
    # Add this
    helm:
      releaseName: nginx
      values: |
        replicaCount: 2
    # till here
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
```
38. Push the change to Gitlab:
```
git add -A
git commit -m "Changes the Nginx installation from plain manifests to Helm"
git push --set-upstream origin feature/nginx-helm
```
39. Copy the link that was generated in the output and paste it in a new browser tab. Approve and merge the MR.

40. Go to the Argo CD UI and click Refresh on the argocd application. Make sure that the nginx application has changed the path to mychart.

41. Go to the terminal and show the new pods by running:
```
kubectl get pods
```

# Deploying a sample application to ArgocD (KUSTOMIZE)
caddy web server and reverse proxy written in Go

1. Go to the base directory.

2. Open the deployment.yaml file and change the contents to be as follows:
```
apiVersion: apps/v1
kind: Deployment
metadata:
    name: caddy-deployment
spec:
    replicas: 1
    selector:
    matchLabels:
        app: caddy
    template:
    metadata:
        labels:
        app: caddy
    spec:
        containers:
        - name: caddy
        image: caddy:alpine
        ports:
        - containerPort: 80
            name: http
        volumeMounts:
        - name: caddy-config
            mountPath: /etc/caddy/
            readOnly: true
        volumes:
        - name: caddy-config
        configMap:
            name: caddy-config
```

3. Create Caddyfile with the following contents:
```
:80
log {
    output stdout
    format json
}
root * /usr/share/caddy
file_server
```
4. Modify the service.yaml and paste the following:
```
apiVersion: v1
kind: Service
metadata:
    name: caddy-service
spec:
    selector:
    app: caddy
    ports:
    - name: http
    port: 80
```
5. Create a new file called ingress.yaml and add the following:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    name: caddy-ingress
spec:
    ingressClassName: nginx
    rules:
    - host: example.com
    http:
        paths:
        - path: /
        pathType: Prefix
        backend:
            service:
            name: caddy-service
            port:
                name: http
```
6. Modify the kustomization.yaml file to look as follows:
```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- deployment.yaml
- service.yaml
- ingress.yaml

configMapGenerator:
- name: caddy-config
    files:
    - Caddyfile

namespace: default
```
7. Move to the overlays directory.

8.Create a new file called ingress.yaml and add the following content:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    name: caddy-ingress
    annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
    ingressClassName: nginx
    rules:
    - http:
        paths:
        - path: /caddy
        pathType: Prefix
        backend:
            service:
            name: caddy-service
            port:
                name: http
```
9. Modify the kustomization.yaml file to be as follows:
```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../base

namespace: default

patches:
- path: ingress.yaml
    target:
    kind: Ingress
    name: caddy-ingress
```
10. Create a new Argo CD application in the argo-cd directory called caddy.yaml and add the following:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
    name: caddy
    namespace: argocd
spec:
    project: default
    source:
    repoURL: 'https://gitlab.com/[username]/samplegitopsapp.git'
    path: overlays
    targetRevision: main
    destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
    syncPolicy:
    automated:
        selfHeal: true
        prune: true
```
11. Create a new branch, add, commit, and push:
```
git checkout -b "feature/adds-caddy"
git add -A
git commit -m "Adds Caddy web server"
git push --set-upstream origin feature/adds-caddy
```
12. Click on the MR link, go to the MR, approve it and merge to master.

13. Go to the Argo CD UI and refresh the Argo CD app.

14. Go to the terminal and show the objects that were created:
```
kubectl get pods
kubectl get svc
kubectl get configmaps
kubectl get ing
```
15. Open a new browser window and navigate to /caddy.

# Managing Secrets in Gitops

## Importance of Secrets Management

- a crucial aspect of any modern application development porcess
- Should be managed securely and separately from a application code
- We need to ensure that secrets are:
  - Encrypted to protect against unauthorized access
  - Versioned to maintain an audit trail and rollback capabilities
  - Automated to reduce manual intervention and human error

## Sealed Secrets overview
- an open-source project by bitnami
- Can securely store, version and manage secrets in a GitOps workflow using argoCd
- consist of
  - Sealed secret CRD
  - Kubeseal
  - Sealed secrets Controller


1. Go to https://github.com/bitnami-labs/sealed-secrets/releases

2. Copy the link to the controller.yaml and use wget to download it.

3. Use kubectl to apply the contents of the file to the cluster.

4. Go back to the downloads page and copy the link to the kubeseal-0.20.5-linux-amd64.tar.gz

5. Use wget to download the file, move it to some directory in the $PATH variable and add the execute permissions:
```
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.20.5/kubeseal-0.20.5-linux-amd64.tar.gz
tar -xvf kubeseal-0.20.5-linux-amd64.tar.gz
sudo mv kubeseal /usr/local/bin
sudo chmod +x /usr/local/bin/kubeseal
```
6. Create a new directory in the myapp directory called apiservice:
```
mkdir apiservice
```
7. Inside the directory, create a deployment.yaml file and add the following content:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: busybox-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: busybox
  template:
    metadata:
      labels:
        app: busybox
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["sh", "-c", "while true; do sleep 3600; done"]
        env:
        - name: APIKEY
          valueFrom:
            secretKeyRef:
              name: appsecret
              key: apikey
      restartPolicy: Always
```
8. Encode the dummy API key into base64 format:
```
echo api_key_2a6f1d23eabc482f9032165de5a8c7 | base64
```
9. Create a new file called secret.yaml and add the following:
```
apiVersion: v1
kind: Secret
metadata:
  name: appsecret
type: Opaque
data:
  apikey: YXBpX2tleV8yYTZmMWQyM2VhYmM0ODJmOTAzMjE2NWRlNWE4Yzc=
```
10. Get the public key using
```
kubeseal --fetch-cert > publickey.pem
```
11. Encrypt the contents of the secret using the following command:
```
kubeseal --format=yaml --cert=publickey.pem < secret.yaml > sealedsecret.yaml
```
12. View the file contents:
```
cat sealedsecret.yaml
```
13. Copy the encrypted string and try to decode it using base64.

14. Delete the secret file:
```
rm secret.yaml
rm publickey.pem
```
15. Create a new application in the argo-cd directory:
```
cd ../argo-cd
vim apiservice.yaml
```
16. The file contents should be as follows:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: apiservice
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://gitlab.com/[username]/samplegitopsapp.git'
    path: apiservice
    targetRevision: main
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
```
17. Create a branch and an MR:
```
git checkout -b "adds-apiservice"
git add -A
git commit -m "Creates the API service and the sealed secret"
git push --set-upstream origin feature/adds-apiservice
```
18. Create and approve the MR from the link.

19. Go to the Argo CD UI and refresh the argo cd applcation.