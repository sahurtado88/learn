# HELM

Helm is an application package manager for Kubernetes that you use to standardize and simplify the deployment of cloud-native applications on Kubernetes.

Helm is a package manager for Kubernetes that combines all your application's resources and deployment information into a single deployment package.

Helm uses four components to manage application deployments on a Kubernetes cluster.

![](https://docs.microsoft.com/en-us/learn/modules/aks-app-package-management-using-helm/media/2-helm-components.svg)

![](./Images/helmcomponents.png)

- **A Helm client**

The Helm client is a client installed binary responsible for creating and submitting the manifest files required to deploy a Kubernetes application. The client is responsible for the interaction between the user and the Kubernetes cluster.

The Helm client is available for all major operating systems and is installed on your client PC. In Azure, the Helm client is pre-installed in the Cloud Shell and supports all security, identity, and authorization features of Kubernetes.

- **Helm charts**

A Helm chart is a templated deployment package that describe a related set of Kubernetes resources. It contains all the information required to build and deploy the manifest files for an application to run on a Kubernetes cluster.

A Helm chart consists of several files and folders to describe the chart. Some of the components are required, and some are optional. What you choose to include is based on the apps configuration requirements. Here is a list of files and folders with the required items in bold.

|File / Folder	|Description|
|-|-|
|**Chart.yaml**|A YAML file containing the information about the chart.|
|**values.yaml**|	The default configuration values for the chart.|
|**templates/**|	A folder that contains the deployment templates for the chart.|
|LICENSE|	A plain text file that contains the license for the chart.|
|README.md	|A markdown file that contains instructions on how to use the chart.|
|values.schema.json**|	A schema file for applying structure on the values.yaml file.|
|charts/	|A folder that contains all the subcharts to the main chart.|
|crds/	|Custom Resource Definitions.|
|templates/Notes.txt|	A text file that contains template usage notes|

- **Helm releases**

A Helm release is the application or group of applications deployed using a chart. Each time you install a chart, a new instance of an application is created on the cluster. Each instance has a release name that allows you to interact with the specific application instance.


- **Helm repositories**

A Helm repository is a dedicated HTTP server that stores information on Helm charts. The server serves a file that describes charts and where to download each chart.

The Helm project hosts many public charts, and many repositories exist from which you can reuse charts. Helm repositories simplify the discoverability and reusability of Helm packages.

## The benefits of using Helm
Helm introduces a number of benefits that simplify application deployment and improves productivity in the development and deployment lifecycle of cloud-native applications. With Helm, you have application releases that are:

- Repeatable

- Reliable

- Manageable in multiple and complex environments

- Reusable across different development teams.

## How does Helm process a chart?
The Helm client implements a Go language-based template engine that parses all available files in a chart's folders. The template engine creates Kubernetes manifest files by combining the templates in the chart's templates/ folder with the values from the Chart.yaml and values.yaml files.

Once the manifest files are available, the client can install, upgrade, and delete the application defined in the generated manifest files.

## How to define a Chart.yaml file
The Chart.yaml is one of the required files in a Helm chart definition and provides information about the chart. The contents of the file consists of three required and various optional fields.

The three required fields are:

The apiVersion . This value is the chart API version to use. You set the version to v2 for Charts that use Helm 3.

The name of the chart.

The version of the chart. The version number uses semantic versioning 2.0.0 and follows the MAJOR.MINOR.PATCH version number notation.

Here is an example of a basic Chart.yaml file:

```

apiVersion: v2
name: webapp
description: A Helm chart for Kubernetes

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore, cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application.
appVersion: 1.0.0

```

## How to define a chart template
A Helm Chart template is a file describes different deployment type manifest files. Chart templates are written in the Go template language and provides additional template functions to automate the creation of Kubernetes object manifest files.

Template files are stored in the templates/ folder of a chart and processed by the template engine to create the final object manifest.

For example, the development team uses the following deployment manifest file to deploy the drone tracking website.
 
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
  labels:
    app: dronetracker
    service: webapp
spec:
  replicas: 1
  selector:
    matchLabels:
      service: webapp
  template:
    metadata:
      labels:
        app: dronetracker
        service: webapp
    spec:
      containers:
        - name: webapp
          image: my-acr-registry.azurecr.io/webapp:linux-v1
          imagePullPolicy: Always
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 250m
              memory: 256Mi
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
```

For example, the development team wants to allow for install time configuration values. The container registry, docker release tag, and Kubernetes pull policy should be configurable in the template. To allow for this configuration, you can modify the existing manifest file with the following example template syntax.

```
apiVersion: apps/v1
kind: Deployment
metadata:
  ...
spec:
  ...
  template:
    ...
    spec:
      containers:
        - name: webapp
          image: {{ .Values.registry }}/webapp:{{ .Values.dockerTag }}
          imagePullPolicy: {{ .Values.pullPolicy }}
          resources:
          ...
          ports:
            ...
```

Notice the use of the {{.Values.<property\>}} syntax. The syntax allows you to create placeholders for each custom value.

The process of creating Helm charts by hand is tedious. An easy way to create a Helm chart is to use the helm create command to create a new Helm chart. You then customize the autogenerated files to match your application's requirements.


## How to define a values.yaml file
You use chart values to customize the configuration of a Helm chart. Chart values can either be predefined or supplied by the user at the time of deploying the chart.

A **predefined** value is a case-sensitive value that is predefined in the context of a Helm Chart and can't be changed by a user. Keep in mind that you can only reference well-known fields. You can think of predefined values as constants to use in the templates you create.

A **supplied** value allows you to process arbitrary values in the chart template. The values.yaml file defines these values.

In the example, the development team allows for three configurable values. A container registry name, a docker release tag, and a Kubernetes pull policy.

```
apiVersion: apps/v1
kind: Deployment
    ...
      containers:
        - name: webapp
          image: {{.Values.registry}}/webapp:{{.Values.dockerTag}}
          imagePullPolicy: {{.Values.pullPolicy}}
          resources:
          ...
```

Here is an example of the values.yaml file

```
apiVersion: v2
name: webapp
description: A Helm chart for Kubernetes
...
registry: "my-acr-registry.azurecr.io"
dockerTag: "linux-v1"
pullPolicy: "Always"

```

Once the template engine applies the values, the final result will look like this example:

```
apiVersion: apps/v1
kind: Deployment
   ...
     containers:
       - name: webapp
         image: my-acr-registry.azurecr.io/webapp:linux-v1
         imagePullPolicy: Always
         resources:
         ...
```

## How to use a Helm repository
A Helm repository is a dedicated HTTP server that stores information on Helm charts. You configure Helm repositories with the Helm client for it to install charts from a repository using the helm repo add command.

Information about charts available on a repository is cached on the client host. You'll need to periodically update the cache manually to fetch the repository's latest information by running the helm repo update command.

The helm search repo command allows you to search for charts on all locally added Helm repositories

## How to test a Helm chart
Helm provides an option for you to generate the manifest files that the template engine creates from the chart. This feature allows you to test the chart before a release by combining two additional parameters. These parameters are --dry-run and debug.

The --dry-run parameter makes sure that the installation is simulated, and the --debug parameter enables verbose output. 

## How to install a Helm chart
You use the helm install command to install a chart. A Helm chart can be installed from any of the following locations.

- Chart folder

helm install my-drone-webapp ./drone-webapp

- A packaged .tgz tar archive chart

helm install my-drone-webapp ./drone-webapp.tgz

- A Helm repository 

helm install my-release azure-marketplace/aspnet-core

## How to use functions and pipelines in a template
The Helm template language defines functions that you use to transform values from the values.yaml file. The syntax for a function follows the {{ functionName arg1 arg2 ... }} structure. Let's look at the quote function as an example to see this syntax in use.

```
{{ quote .Values.ingress.enabled }}
```

You use pipelines when more than one function needs to act on a value. A pipeline allows you to send a value, or the result of a function, to another function.

```
{{ .Values.ingress.enabled | upper | quote }}
```

## How to use conditional flow control in a template

Conditional flow control allows you to decide the structure or data included in the generated manifest file. For example, you may want to include different values based on the deployment target or control if a manifest file is generated.

The if / else block is such a control flow structure and conforms to the following layout.

```
{{- if .Values.ingress.enabled -}}
apiVersion: extensions/v1
kind: Ingress
metadata:
  name: ...
  labels:
    ...
  annotations:
    ...
spec:
  rules:
    ...
{{- end }}

```

Notice the use of the - character as part of the start {{- and the end -}} sequence of the statement. The - character instructs the parser to remove whitespace characters. {{- removes whitespace at the start of a line and -}} at the end of a line, including the newline character.

## How to iterate through a collection of values in a template

YAML allows you to define collections of items and use individual items as values in your templates. Accessing items in a collection is possible using an indexer. However, the Helm template language supports the iteration of a collection of values using the range operator.

```
ingress:
  enabled: true
  extraHosts:
    - name: host1.local
      path: /
    - name: host2.local
      path: /
    - name: host3.local
      path: /
```
```
{{- if .Values.ingress.enabled -}}
apiVersion: extensions/v1
kind: Ingress
metadata:
  ...
spec:
  rules:
    ...
    {{- range .Values.ingress.extraHosts }}
    - host: {{ .name }}
      http:
        paths:
          - path: {{ .path }}
            ...
    {{- end }}
  ...
{{- end }}
```

## How to define chart dependencies

The helm dependency command allows you to manage dependencies included from a Helm repository. The command uses metadata defined in the dependencies section of your chart's values file. You specify the name, version number, and the repository from where to install the sub chart. Here is an extract of a values.yaml file that has a MongoDB chart listed as a dependency.

```
apiVersion: v2
name: my-app
description: A Helm chart for Kubernetes
...
dependencies:
  - name: mongodb
    version: 10.27.2
    repository: https://marketplace.azurecr.io/helm/v1/repo

```

Once the dependency metadata is defined, you run the helm dependency build command to fetch the tar packaged chart. The chart build command downloads the chart into the charts/ folder.

## How to upgrade a Helm release

Helm allows upgrading existing releases as a delta of all the changes that apply to the chart and its dependencies.

Instead of uninstalling the current release, you'll use the helm upgrade command to upgrade the existing Helm release. Here is an example of what the command may look like when run.

```
helm upgrade my-app ./app-chart
```

## How to roll back a Helm release

Helm allows the rollback of an existing Helm release to a previously installed release. Recall from earlier, Helm tracks release information of all releases of a Helm chart.

You use the helm rollback command to roll back to a specific Helm release revision. This command uses two parameters. The first parameter identifies the name of the release, and the second identifies the release revision number. Here is an example of the command.

```
helm rollback my-app 2

```

## HELM command

- Add repo

helm repo add NAME URL repo

helm repo add bitnami https://chart.bitnami.com/bitnami

- repo list

helm repo list

- searh in repo

helm search repo NOMBREAPP

helm search repo apache

Buscar diferente a la ultima version

helm search repo mysql --version

- remove repo

helm repo remove NAME

helm repo remove bitnami


- dry run

--dry-run debbuging mode

helm uninstall myserver --keep-history paraque se pueda realizar rollback

helm history mywebserver historia de versiones

helm rollback webservice 3 para hacer rolback a la version 3


helm upgrade --instal mywebserver bitnami/apache  crear o hacerun upgrade depende si existe o no

helm install bitnami/apache --generate-name crea n nombre aleatorio

helm install bitnami/apache --generate-name  --name-template "mywebserver-{{randAlpha 7 | lower}} crearnombre con un template

## WAIT AND TIMEOUT

helm install mywbserver bitnmi/apache --wait --timeout 5m10s   5 minutos es el wait por defecto

## ATOMIC INSTALL

helm install mywebserver bitnami/apache --atomic --timeout 7m12s devueve a un rollback de un despliegue exitoso

## FOrceful Upgrades

helm up

## clean up

helm upgrademywebserver bitnami/apache --cleanup-on-failure

## create chart

helm create firstchart

### STRUCTURE OF THE CHART
Chart.yaml metadata
chart folder dependencias
templates folder all the templates to render manifest kubernetes
values.yaml contain all the values

## iChart.yaml

aqui esta la metadata  son obligatorios la apiVersion, name and version the rest is optional

helm lint

helm lint firstchart

________________________

## Inicializar un Repositorio de Helm Chart
Una vez que tengas Helm listo, puede agregar un repositorio de Charts. Consulta Artifact Hub para conocer los repositorios de Helm Chart disponibles.

helm repo add stable https://charts.helm.sh/stable

## Instalar un Chart de Ejemplo
Para instalar un chart, puede ejecutar el comando helm install. Helm tiene varias formas de buscar e instalar un chart, pero la más fácil es utilizar uno de los charts stable oficiales.

helm repo update  # Asegúrese de obtener la última lista de charts

helm install stable/mysql --generate-name

Released smiling-penguin

La función helm list le mostrará una lista de todos los releases desplegados.

## Desinstalar un Release
Para desinstalar un release, utilice el comando helm uninstall:

helm uninstall smiling-penguin

Esto desinstalará smiling-penguin de Kubernetes, lo que eliminará todos los recursos asociados con el release, así como el historial del release.

Si la bandera --keep-history es utilizada, el historial del release será mantenido. Podrás solicitar información sobre ese release:

## La Estructura de Archivos del Chart
Un chart se organiza como una colección de archivos dentro de un directorio. El nombre del directorio es el nombre del chart (sin información de versiones). Por lo tanto, un chart que describa WordPress se almacenaría en un directorio wordpress/.

Dentro de este directorio, Helm esperará una estructura que coincida con esto:

![](./Images/chartsstructure.png)



Helm se reserva el uso de los directorios charts/, crds/ y templates/, y de los nombres de archivo listados. Los demás archivos se dejarán como están.

___________________________


helm get manifest nombrechart

helm install --debug --dry-run nombrerelease nombrecharts

set values have precedence

helm install nombrerelease nombrechart --set variable=valorvariable

you cna use function http://masterminds.github.io/sprig/ to quote or upper a text value

si se necesita aplicar mas d euna funcion se usa el pipe {{Value.projecCode | upper | quote}}

valor por defecto {{ Values.contact | default "1-800-123-0000"} | quote}

## Flow control - If/else

![](./Images/flowcontrol.png)

# HELM apasoft

- Un Chart es un paquete de Helm. Contiene todas las definiciones de recursos necesarias para ejecutar una aplicación, herramienta o servicio dentro de un clúster de Kubernetes. Piense en él como el equivalente de Kubernetes de una fórmula Homebrew, un Apt de dpkg o un archivo Yum de RPM.

- Un Repositorio es el lugar donde se pueden recopilar y compartir Charts. Es como el archivo CPAN de Perl o la Base de Datos de Paquetes de Fedora, pero para los paquetes de Kubernetes.

- Un Release es una instancia de un Chart que se ejecuta en un clúster de Kubernetes. A menudo, un Chart se puede instalar muchas veces en el mismo clúster. Y cada vez que se instala, se crea un nuevo release. Considere un Chart MySQL. Si desea que se ejecuten dos bases de datos en su clúster, puede instalar ese Chart dos veces. Cada uno tendrá su propio release, que a su vez tendrá su propio nombre de release.


## Repositorios

- un repositorio en helm es un sitio HTTP que contiene un conjunto de charts o paquetes helm
- ademas tieen un archivo 2indice" que detalla el contenido dle repositorio
    - este archvio se denomina index.yaml
- los charts aparecen empaquetados como .tar.gz
- Helm tiene comandos para gestionar el reposaitorio, añadir y empaquetar charts e incluso crear el archivo index.yaml
- Algunas de las opciones donde podemos crear un repositorio son
    - servidor we
    - servicio de almacenamiento como github
    - google cloud storgae (GSC) bucket
    - Amazon s3 bucket

### Añadir repositorios

```
helm repo add stable https://charts.helm.sh/stable
```

### Listar repos

```
helm repo list
```
### Buscar repo

'helm search': Buscando Charts
Helm viene con un poderoso comando de búsqueda. Se puede utilizar para buscar dos tipos diferentes de fuentes:

```helm search hub``` buscar en Artifact Hub, que enumera charts de Helm de docenas de repositorios diferentes.

```helm search repo ``` busca en los repositorios que ha agregado a su cliente de helm local (con helm repo add). Esta búsqueda se realiza a través de datos locales y no se necesita una conexión de red pública.

```
helm search repo | grep bitnami
```
```
helm search repo apache
```
```
helm search repo apache --version 1.0.5
```

### contextos de HELM

```
helm env
```
### borrar repo

```
helm repo remove elastic
```

## Instalar un chart

```
helm install apache1 bitnami/apache

helm install <release> <nombre chart>
```

## Helm commands

```
helm list
```

```
helm status <realease>
```

```
helm get manifest <release>
```

```
helm get notes <release>
```

```
helm get values <release>
```

```
helm get all <release>
```

```
helm show readme <chart>
```

```
helm show readme <nombre chart>
```

```
helm show chart <nombre chart>
```

```
helm show values <nombre chart>
```

```
helm show all <nombre chart>
```

## Upgrade de una release

```
helm upgrade <release> <nombre chart>
```

```
helm upgrade --set service.port=8080 apache1 bitnami/apache
```

## upgrade mediante ficheros de valores

```
helm show values bitnami/apache > valores.yaml
```

editar valores.yaml

```
helm upgrade -f valores.yaml apache1 bitnami/apache
```

## hacer un rollback a una version anterior

```
helm history <release>
```

```
helm rollback <release> <version>
```

## Borrar realease

probar la desinstalacion
```
helm uninstall --dry-run <release>
```

deinstlaa y guarda el historico
```
helm uninstall --keep-history <release>
```

## Creacion de charts

### Estructura de un chart

Chart.yaml -> fichero YAML que contiene informacion sobre el chart
LICENSE -> Opcional: fichero de texto con licencia del chart
README.md -> Opcional: fichero README
values.yaml -> Valores por defecto para este chart
values.schema.json -> Opcional. esquema JSON que determina la estructura del fichero values.yaml
charts/ -> Directorio que contiene los charts de los que depende este chart
templates/ -> Direcotrio de plantillas que combinado con los valores generará los ficheros de manifest de kubernetes
templates/NOTES.txt -> Opcional: Fichero plano con las notas sobre el uso del chart

### crear un chart

crea una estructura basica
```
helm create <nombre chart>
```

### Primera ejemplo de plantilla y despliegue

```
helm install <release> <directorio Chart>
```

```
apiVersion: v1
kind: Pod
metadata:
  name: {{.Release.Name }}-nginx1
  labels:
    zone: prod
    version: v1
spec:
  containers:
   - name: nginx
     image: apasoft/nginx:v1

```

### comprobar plantilla antes de instalalr

```
helm install --dry-run <release> <directorio_chart>
```

```
helm install --debug --dry-run <release> <directorio_chart>
```

### Ignorar ficheros en la instalacion

.helmignore nos permite ignorar archivos

### Objetos

- **Release:** This object describes the release itself. It has several objects inside of it:
  - Release.Name: The release name
  - Release.Namespace: The namespace to be released into (if the manifest doesn’t override)
  - Release.IsUpgrade: This is set to true if the current operation is an upgrade or rollback.
  - Release.IsInstall: This is set to true if the current operation is an install.
  - Release.Revision: The revision number for this release. On install, this is 1, and it is incremented with each upgrade and rollback.
  - Release.Service: The service that is rendering the present template. On Helm, this is always Helm.
- **Values** values passed into the template from the values.yaml file and from user-supplied files. By default, Values is empty
- **Chart** The contents of the Chart.yaml file. Any data in Chart.yaml will be accessible here. For example {{ .Chart.Name }}-{{ .Chart.Version }} will print out the mychart-0.1.0.
- **Subcharts** This provides access to the scope (.Values, .Charts, .Releases etc.) of subcharts to the parent. For example .Subcharts.mySubChart.myValue to access the myValue in the mySubChart chart.
- **Files**: This provides access to all non-special files in a chart. While you cannot use it to access templates, you can use it to access other files in the chart. See the section Accessing Files for more.
  - Files.Get is a function for getting a file by name (.Files.Get config.ini)
  - Files.GetBytes is a function for getting the contents of a file as an array of bytes instead of as a string. This is useful for things like images.
  - Files.Glob is a function that returns a list of files whose names match the given shell glob pattern.
  - Files.Lines is a function that reads a file line-by-line. This is useful for iterating over each line in a file.
  - Files.AsSecrets is a function that returns the file bodies as Base 64 encoded strings.
  - Files.AsConfig is a function that returns file bodies as a YAML map.

- **Capabilities**: This provides information about what capabilities the Kubernetes cluster supports.
  - Capabilities.APIVersions is a set of versions.
  - Capabilities.APIVersions.Has $version indicates whether a version (e.g., batch/v1) or resource (e.g., apps/v1/Deployment) is available on the cluster.
  - Capabilities.KubeVersion and Capabilities.KubeVersion.Version is the Kubernetes version.
  - Capabilities.KubeVersion.Major is the Kubernetes major version.
  - Capabilities.KubeVersion.Minor is the Kubernetes minor version.
  - Capabilities.HelmVersion is the object containing the Helm Version details, it is the same output of helm version.
  - Capabilities.HelmVersion.Version is the current Helm version in semver format.
  - Capabilities.HelmVersion.GitCommit is the Helm git sha1.
  - Capabilities.HelmVersion.GitTreeState is the state of the Helm git tree.
  - Capabilities.HelmVersion.GoVersion is the version of the Go compiler used.
- **Template**: Contains information about the current template that is being executed
  - Template.Name: A namespaced file path to the current template (e.g. mychart/templates/mytemplate.yaml)
  - Template.BasePath: The namespaced path to the templates directory of the current chart (e.g. mychart/templates).

### Objeto release

```
apiVersion: v1
kind: Pod
metadata:
  name: {{.Release.Name }}-nginx1
  labels:
    zone: ejemplo
    version: produccion
    eti1: {{.Release.Time}}
  annotations: {
    fecha: tiempo-{{.Release.Time}} ,
    namespace: nombre-{{.Release.Namespace}},
    actualizacion: Actualizacion-{{.Release.IsUpgrade}},
    instalacion: Instalacion-{{.Release.IsInstall}},
    revision: Revision-{{.Release.Revision}}
  }
spec:
  containers:
   - name: nginx   
     image: apasoft/nginx:v1
```

## Values

In the previous section we looked at the built-in objects that Helm templates offer. One of the built-in objects is Values. This object provides access to values passed into the chart. Its contents come from multiple sources:

- The values.yaml file in the chart
- If this is a subchart, the values.yaml file of a parent chart
- A values file if passed into helm install or helm upgrade with the -f flag (helm install -f myvals.yaml ./mychart)
- Individual parameters passed with --set (such as helm install --set foo=bar ./mychart)

The list above is in order of specificity: values.yaml is the default, which can be overridden by a parent chart's values.yaml, which can in turn be overridden by a user-supplied values file, which can in turn be overridden by --set parameters.

Values files are plain YAML files. Let's edit mychart/values.yaml and then edit our ConfigMap template.


values.yaml

```
bbdd: kubernetes
pass: ipass
usudb: usudb
rootpass: rpass
namespace: default
```

en el directorio Templates

```
apiVersion: v1
data:
  MYSQL_DATABASE: {{.Values.bbdd}}
  MYSQL_PASSWORD: {{.Values.pass}}
  MYSQL_ROOT_PASSWORD: {{.Values.rootpass}}
  MYSQL_USER: {{.Values.usudb}}
kind: ConfigMap
metadata:
  name: {{.Release.Name}}-datos-mysql-env
  namespace: default

```

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{.Release.Name}}-mysql-deploy
  labels:
    app: mysql
    type: db
  namespace: {{.Values.namespace}}
spec:
  replicas: 1
  selector: 
    matchLabels:
      app: mysql
      type: db
  template:
    metadata:
      labels:
        app: mysql
        type: db
    spec:
      containers:
        - name: mysql57
          image: mysql:5.7
          ports:
            - containerPort: 3306
              name: db-port
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: {{.Release.Name}}-datos-mysql-env
                  key: MYSQL_ROOT_PASSWORD

            - name: MYSQL_USER
              valueFrom:
                configMapKeyRef:
                  name: {{.Release.Name}}-datos-mysql-env
                  key: MYSQL_USER
            
            - name: MYSQL_DATABASE
              valueFrom:
                configMapKeyRef:
                  name: {{.Release.Name}}-datos-mysql-env
                  key: MYSQL_DATABASE

            - name: MYSQL_PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: {{.Release.Name}}-datos-mysql-env
                  key: MYSQL_PASSWORD

```

### Valores compuestos

```
apiVersion: apps/v1 # i se Usa apps/v1beta2 para versiones anteriores a 1.9.0
kind: Deployment
metadata:
  name: {{.Release.Name}}-nginx-d
  labels:
    estado: "1"
spec:
  selector:   #permite seleccionar un conjunto de objetos que cumplan las condicione
    matchLabels:
      app: nginx
  replicas: 5 # indica al controlador que ejecute 2 pods
  template:   # Plantilla que define los containers
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
        resources:
          limits:
              memory: {{.Values.limites.memoria}}
              cpu: {{.Values.limites.cpu}}
          requests:
              memory: {{.Values.peticiones.memoria}} 
              cpu: {{.Values.peticiones.cpu}}

```
values.yaml
```
# Default values for chart-values.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.
limites:
      memoria: "200Mi"
      cpu: "2"
peticiones:
      memoria: "100Mi"
      cpu: "0.5"


#### limites.memoria

```

### Cambiar valores con un fichero

el orden de carga de los valores 

1. el fichero values.yaml del chart
2. un fichero de valores pasados en el install o upgrade con la opcion -f
3. parametros pasados con --set

```
helm upgrade <release> <nombre_directorio_chart> -f <fichero con los nuevos values>
```

### cambiar valores con set

```
helm install --set foo=bar ./mychart
```
## Condiciones y bucles

### Variables

In Helm templates, a variable is a named reference to another object. It follows the form $name. Variables are assigned with a special assignment operator: :=. We can rewrite the above to use a variable for Release.Name.

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  {{- $relname := .Release.Name -}}
  {{- with .Values.favorite }}
  drink: {{ .drink | default "tea" | quote }}
  food: {{ .food | upper | quote }}
  release: {{ $relname }}
  {{- end }}
```
Notice that before we start the with block, we assign $relname := .Release.Name. Now inside of the with block, the $relname variable still points to the release name.

### Comentarios

en helm se usa 
```
{{- /*
HELM COMMENT
*/}}
```

### Flow Control

Control structures (called "actions" in template parlance) provide you, the template author, with the ability to control the flow of a template's generation. Helm's template language provides the following control structures:

if/else for creating conditional blocks
with to specify a scope
range, which provides a "for each"-style loop

In addition to these, it provides a few actions for declaring and using named template segments:

- define declares a new named template inside of your template
- template imports a named template
- block declares a special kind of fillable template area

#### **Estrucutra if**

{{ in CONDICION }}
  PROCESO
{{ else if CONDICION }}
  HACER OTRA COSA
{{ else }}
  OPCION POR DEFECTO
{{ end }}

A pipeline is evaluated as false if the value is:

a boolean false
a numeric zero
an empty string
a nil (empty or null)
an empty collection (map, slice, tuple, dict, array)

#### **operadores**

eq ne lt gt ge le and or

#### ejemplo if

```
apiVersion: v1
kind: Pod
metadata:
  name: {{.Release.Name}}-tomcat
  labels:
    estado: "aprobado"
    responsable: "juan"
spec:
  containers:
   - name: tomcat1     
     {{- /*

     HELM comment . Esta condicio hace...

     */}}
     {{ $version := "" }} 
     {{ if eq .Values.entorno "desarrollo" }}
     image: tomcat:9.0
     {{ else }}
     image: tomcat:10.0
     {{ end }}

```

#### **Controlling Whitespace**

YAML ascribes meaning to whitespace, so managing the whitespace becomes pretty important. Fortunately, Helm templates have a few tools to help.

First, the curly brace syntax of template declarations can be modified with special characters to tell the template engine to chomp whitespace. {{- (with the dash and space added) indicates that whitespace should be chomped left, while -}} means whitespace to the right should be consumed. Be careful! Newlines are whitespace!

Make sure there is a space between the - and the rest of your directive. {{- 3 }} means "trim left whitespace and print 3" while {{-3 }} means "print -3".

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  drink: {{ .Values.favorite.drink | default "tea" | quote }}
  food: {{ .Values.favorite.food | upper | quote }}
  {{- if eq .Values.favorite.drink "coffee" }}
  mug: "true"
  {{- end }}
```

#### **Modifying scope using with**

The next control structure to look at is the with action. This controls variable scoping. Recall that . is a reference to the current scope. So .Values tells the template to find the Values object in the current scope.

The syntax for with is similar to a simple if statement:

```
{{ with PIPELINE }}
  # restricted scope
{{ end }}
```
Scopes can be changed. with can allow you to set the current scope (.) to a particular object. For example, we've been working with .Values.favorite. Let's rewrite our ConfigMap to alter the . scope to point to .Values.favorite:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  {{- with .Values.favorite }}
  drink: {{ .drink | default "tea" | quote }}
  food: {{ .food | upper | quote }}
  {{- end }}
```

#### **Looping with the range action**

Many programming languages have support for looping using for loops, foreach loops, or similar functional mechanisms. In Helm's template language, the way to iterate through a collection is to use the range operator.

To start, let's add a list of pizza toppings to our values.yaml file:

```
favorite:
  drink: coffee
  food: pizza
pizzaToppings:
  - mushrooms
  - cheese
  - peppers
  - onions
```

Now we have a list (called a slice in templates) of pizzaToppings. We can modify our template to print this list into our ConfigMap:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  {{- with .Values.favorite }}
  drink: {{ .drink | default "tea" | quote }}
  food: {{ .food | upper | quote }}
  {{- end }}
  toppings: |-
    {{- range .Values.pizzaToppings }}
    - {{ . | title | quote }}
    {{- end }}    
```
#### Condiciones OR y AND

```

## Ejemplo de Valores para If complejo
#
replicas: 4


puerto: 80
nodeport: 30002

##############################################
##  Tipo de servicio --> n   para NodePort   #
##                       c   para ClusterIp  #
##############################################

tiposervicio: "c"

##############################################
##  entorno  -->  desarrollo      #
##                test
##                produccion
##############################################

entorno: desarrollo

departamento: RRHH

```

servicio yaml

```
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name}}-svc-apache
  labels:
     app: apache
spec:
  {{- if eq .Values.tiposervicio "n"}}
  type: NodePort
  {{ else}}
  type: ClusterIP
  {{ end }}
  ports:
  - port: {{ .Values.puerto }}
    {{- if eq .Values.tiposervicio "n" }}
    nodePort: {{ .Values.nodeport }}
    {{ end }}
    protocol: TCP
  selector:
     app: apache

```

deployapache yaml

```
apiVersion: apps/v1 
kind: Deployment
metadata:
  name: {{ .Release.Name}}-apache
spec:
  selector:   
    matchLabels:
      app: apache
  replicas: {{ .Values.replicas}} 
  template:   
    metadata:
      labels:
        app: apache
    spec:
      containers:
      - name: apache
      {{- if and  (eq .Values.entorno  "desarrollo") ( eq .Values.departamento "RRHH" )  }}
        image: httpd:2.4
      {{ else}}
        image: httpd:2.2
      {{ end }}
        ports:
        - containerPort: {{ .Values.puerto}}


```
#### Bucles

configmap en templates

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name}}-config
  namespace: default
data:
  departamentos: |-
    {{- range .Values.departamentos }}
    - {{ . }}
    {{- end }}
```

values

```
# Default values for Bucles.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

departamentos:
  - rrhh
  - sales
  - TI
  - Marketing
```

#### Bucles con variables

configmap 

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name}}-config
  namespace: default
data:
  departamentos: |-
    {{- range $indice,$valor:=.Values.departamentos }}
    - {{ $indice }}: {{$valor}}
    {{- end }}

```

values

```
# Default values for Bucles.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

departamentos:
  - rrhh
  - sales
  - TI
  - Marketing
```

#### WITH

values

```
departamentos:
  rrhh: Cali
  sales: Medellin
  TI: Bogota
  Marketing: Pereira

```

configmap en templates
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name}}-config
  namespace: default
data:
{{- with .Values.departamentos }}
  {{- range .}}
    ciudad: {{.}}
  {{- end }}
{{- end }}
```

### Funciones

Helm includes many template functions you can take advantage of in templates. They are listed here and broken down by the following categories:

Cryptographic and Security
Date
Dictionaries
Encoding
File Path
Kubernetes and Chart
Logic and Flow Control
Lists
Math
Float Math
Network
Reflection
Regular Expressions
Semantic Versions
String
Type Conversion
URL
UUID

https://helm.sh/docs/chart_template_guide/function_list/


#### Ejemplo funciones

configmap templates
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name}}-config
  namespace: default
data:
  quote: {{ quote .Values.city }}
  upper: {{ upper .Values.city }}
  now: {{ now }}
  substr: {{ substr 0 3 .Values.city }}
  network: {{getHostByName "curso" }}
  network: {{getHostByName "www.google.com" }}
```

values

```
city: california
```

#### Pipelines 

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name}}-config
  namespace: default
data:
  quote: {{ quote .Values.city | upper }}
  upper: {{ upper .Values.city | repeat 3 }}
  now: {{ now |  htmlDate }}
  network: {{ getHostByName "curso" | substr 0 3}}
```


https://helm.sh/docs/chart_template_guide/debugging/

### Subplantillas o Partials

_helpers.tpl es una subplantilla

_subtemplates.tpl

```
{{- define "plantilla1.etiquetas" }}
  labels: 
     responsable: Thomas
     fecha: {{ now | htmlDate }}
     
{{- end }}
```

deployment en templates

```
apiVersion: apps/v1 
kind: Deployment
metadata:
  name: {{ .Release.Name}}-web-sonda
  {{- template "plantilla1.etiquetas"  }}
spec:
  selector:   
    matchLabels:
      app: web
  replicas: 1 
  template:   
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web-sonda
        image: apasoft/sonda-web:latest
        ports:
        - containerPort: 80
        livenessProbe:
            httpGet:
                path: /sonda.html
                port: 80
            initialDelaySeconds: 3
            periodSeconds: 3
```

#### Contexto subplantilla

_subtemplate.tpl

```
{{- define "plantilla1.etiquetas" }}
  labels: 
     responsable: Thomas
     fecha: {{ now | htmlDate }}
     nombre: {{ .Chart.Name }}
{{- end }}
```

Chart.yaml

```
apiVersion: v2
name: Plantilla3
description: A Helm chart for Kubernetes

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
# Versions are expected to follow Semantic Versioning (https://semver.org/)
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
appVersion: 1.16.0

```

deploy en template

```
apiVersion: apps/v1 
kind: Deployment
metadata:
  name: {{ .Release.Name}}-web-sonda
  {{- template "plantilla1.etiquetas" . }}
spec:
  selector:   
    matchLabels:
      app: web
  replicas: 1 
  template:   
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web-sonda
        image: apasoft/sonda-web:latest
        ports:
        - containerPort: 80
        livenessProbe:
            httpGet:
                path: /sonda.html
                port: 80
            initialDelaySeconds: 3
            periodSeconds: 3
```

aqui se define el contexto {{- template "plantilla1.etiquetas" . }} el punto es que es en la carpeta root