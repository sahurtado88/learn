# DevOps Project 2024- CI/CD with Jenkins helm on AKS & EKS

## Install jenkins

### Install java

We will be using open java for our demo, Get latest version from http://openjdk.java.net/install/

yum install java-11*

### Lets install java and set the java home

```
java -version
find / -name java-11* | head -n 4
/etc/alternatives/java-11-amazon-corretto
/etc/alternatives/java-11
/usr/lib/jvm/java-11-amazon-corretto.x86_64
/usr/lib/jvm/java-11-amazon-corretto

vi .bash_profile
JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto.x86_64
export JAVA_HOME
PATH=$PATH:$JAVA_HOME
# To set it permanently update your .bash_profile
source ~/.bash_profile
```
The output should be something like this,

```
[root@~]# java -version
openjdk version "11.0.17" 2022-10-18 LTS
OpenJDK Runtime Environment Corretto-11.0.17.8.1 (build 11.0.17+8-LTS)
OpenJDK 64-Bit Server VM Corretto-11.0.17.8.1 (build 11.0.17+8-LTS, mixed mode)
```

### Install Jenkins
You can install jenkins using the rpm or by setting up the repo. We will setup the repo so that we can update it easily in future. Get latest version of jenkins from https://pkg.jenkins.io/redhat-stable/

```
yum -y install wget
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins
```

### Start Jenkins
```
# Start jenkins service
systemctl start jenkins

# Setup Jenkins to start at boot,
systemctl enable jenkins
```

```
chkconfig jenkins on # chkconfig puede ser usado para activar y desactivar servicios. chkconfig tambien puede ser usado para configurar un servicio para que comience (o no) en un nivel de ejecucion especifico
```

### Accessing Jenkins
By default jenkins runs at port 8080, You can access jenkins at
```
http://YOUR-SERVER-PUBLIC-IP:8080
```

### Configure Jenkins
- The default Username is admin
- Grab the default password
- Password Location:/var/lib/jenkins/secrets/initialAdminPassword
- Skip Plugin Installation; We can do it later
- Change admin password
    Admin > Configure > Password
- Configure java path
    Manage Jenkins > Global Tool Configuration > JDK
- Create another admin user id

### Test Jenkins Jobs

1. Create “new item”
2. Enter an item name – My-First-Project
3. Chose Freestyle project
4. Under Build section Execute shell : echo "Welcome to Jenkins Demo"
5. Save your job
6. Build job
7. Check "console output"

## Instal jenkins EC2 user data

1. Ubuntu https://medium.com/@dassandrew3/aws-make-an-ec2-user-script-to-download-jenkins-on-an-ubuntu-instance-a7d77ae03ab4
2. Linux AMI 2 https://www.linkedin.com/pulse/using-user-data-script-jenkins-installation-aws-ec2-linux-shah

### Security Groups EC2 jenkins

allow inbound rules to ssh port 22 y custom TCP 8080 to jenkins

### AWS CLI in jenkin server

```
sudo yum remove awscli # If this is your first time updating on Amazon Linux, to install the latest version of the AWS CLI, you must uninstall the pre-installed yum version using thiscommand

# to install
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# To update your current installation of the AWS CLI, add your existing symlink and installer information to construct the install command using the --bin-dir, --install-dir, and --update parameters. The following command block uses an example symlink of /usr/local/bin and example installer location of /usr/local/aws-cli.#

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

```

## Maven and Git install and configure Jenkins Server

### Install Maven
wget in opt directory
```
yum install wget
wget https://mirror.lyrahosting.com/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz
tar -xvzf apache-maven-3.8.1-bin.tar.gz
export M2_HOME=/opt/apache-maven-3.8.1
export M2=$M2_HOME/bin
PATH=$PATH:$M2
# To set it permanently update your .bash_profile
source ~/.bash_profile

Validate Maven

mvn version
```

### Install git

```
yum install git

```

### Assign shell to jenkins user

```
vi /etc/passwd
change shell from /bin/false to /bin/bash
```
## Install docker inside jenkins server

### install docker

```
yum install docker
systemctl start docker
systemctl enable docker
```

### provide permissions to jenkins user in jenkins server to access docker
```
  sudo groupadd docker
  sudo usermod -aG docker jenkins
  sudo chmod 777 /var/run/docker.sock
```
### Add Jenkins user into sudoers file to get sudo access
```
   vi /etc/sudoers
   jenkins ALL=(ALL) NOPASSWD: ALL
```

## Install pliugin in jenkins (docker and maven)


https://github.com/initsixcloud/Docs/blob/main/EKS-Setup.MD











____________

https://www.linkedin.com/pulse/improving-operating-model-service-deployments-aws-eks-luciano-bastet-jsuef/?trackingId=umVn3rcDTa6LZFwrL3rQCg%3D%3D

