# What are Helm Charts?

Helm Charts is used for combining all the Kubernetes YAML Manifests in a single package which can also be advertised to our Kubernetes Cluster.Once we install Helm CHart in our cluster it is easy as running one single helm, that simplifies the deployment of the containerized Applications.

# What is the Folder Structure of Helm Chart?
Folder Structure of the Helm Charts are as follows:
Chart.yaml contains all the information about the charts.
LICENSE used in containing the License for the chart.
README.md is a readable file.
values.yaml used in configuring the values for the chart.
values.schema.json is a schema used in imposing the structure of values.yaml file.
charts/ used in containing charts which are depends on this chart.
crds/ is a custom resource definition.
templates/ are used in combining directory of templates with the values and in generating valid kubernetes manifest files.
templates/NOTES.txt used in containing Short Usage Notes.

# What are the concepts used in Helm?
Concepts used by Helm are:
Chart - It is a package consists of pre configured Kubernetes Resources.
Release - It is an instance that can be deployed to the Cluster with the help of Helm.
Repository - It is a group of charts that are available for others.


# What is _helpers TPL in helm?
tpl? Helm allows for the use of Go templating in resource files for Kubernetes. A file named _helpers.tpl is usually used to define Go template helpers with this syntax: {{- define “yourFnName” -}} {{- printf “%s-%s” .Values.name .Values.version | trunc 63 -}} {{- end -}}

# What is value yaml?
The values. yaml file is used to pass values into the Release helm chart. The file contains default parameters that you can override. The values. yaml file is typically located in the folder where you extracted the Release Helm chart zip file.

# What are annotations in Kubernetes?
Annotations allow you to add non-identifying metadata to Kubernetes objects. Examples include phone numbers of persons responsible for the object or tool information for debugging purposes. In short, annotations can hold any kind of information that is useful and can provide context to DevOps teams.

