# Kubernetes Ingress 

# 1. Configuración de Istio como Ingress Controller en EKS
Istio utiliza su Gateway como controlador de entrada. Esto reemplaza el controlador Ingress tradicional.

## 1.1 Preparar el clúster de EKS
Asegúrate de tener instalado el cliente de AWS CLI, kubectl, y eksctl. Configura tu clúster EKS si aún no lo tienes:
bash
Copy code
eksctl create cluster --name my-cluster --region us-west-2 --nodes 3
Conéctate al clúster:
bash
Copy code
aws eks --region us-west-2 update-kubeconfig --name my-cluster
## 1.2 Instalar Istio
Descarga e instala Istio:
bash
Copy code
curl -L https://istio.io/downloadIstio | sh -
cd istio-<VERSION>
export PATH=$PWD/bin:$PATH
Instala Istio en el clúster:
bash
Copy code
istioctl install --set profile=demo -y
Verifica los pods:
bash
Copy code
kubectl get pods -n istio-system
## 1.3 Configurar el Ingress Gateway
Define un Gateway para Istio. Por ejemplo, istio-gateway.yaml:
yaml
Copy code
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: my-gateway
  namespace: default
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
Aplica el Gateway:
bash
Copy code
kubectl apply -f istio-gateway.yaml
## 1.4 Crear un VirtualService
Define un VirtualService para enrutar el tráfico:

yaml
Copy code
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: my-app
  namespace: default
spec:
  hosts:
  - "*"
  gateways:
  - my-gateway
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: my-app
        port:
          number: 8080
Aplica el VirtualService:

bash
Copy code
kubectl apply -f virtualservice.yaml
Obtén la IP pública del Ingress Gateway:

bash
Copy code
kubectl get service istio-ingressgateway -n istio-system
Usa esta IP para acceder a tu aplicación.

# 2. Configuración de NGINX como Ingress Controller en EKS
El controlador de NGINX actúa como un proxy inverso para gestionar el tráfico HTTP/S.

## 2.1 Preparar el clúster de EKS
Asegúrate de que tu clúster esté configurado y que tengas acceso mediante kubectl. Si aún no tienes un clúster EKS, crea uno como se describe en el paso anterior.

## 2.2 Instalar el NGINX Ingress Controller
Agrega el repositorio de Helm:
bash
Copy code
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
Instala NGINX Ingress Controller:
bash
Copy code
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace
Verifica la instalación:
bash
Copy code
kubectl get pods -n ingress-nginx
## 2.3 Configurar un recurso Ingress
Define un recurso Ingress. Por ejemplo, nginx-ingress.yaml:

yaml
Copy code
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: my-app.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 8080
Aplica el recurso Ingress:

bash
Copy code
kubectl apply -f nginx-ingress.yaml
Obtén la IP pública del controlador Ingress:

bash
Copy code
kubectl get service ingress-nginx-controller -n ingress-nginx
Configura el dominio my-app.example.com en tu DNS apuntando a esta IP.

Consideraciones finales para EKS
Istio: Ideal si necesitas funcionalidades avanzadas como balanceo de tráfico, observabilidad y seguridad de servicios.
NGINX: Más sencillo y directo para exponer aplicaciones en el clúster.
Si tienes preguntas específicas o necesitas ejemplos adicionales, ¡avísame!







# diferencia entre un servicio y un virtual service en kubernetes

En Kubernetes, Servicio (Service) y VirtualService son conceptos relacionados con la conectividad de red, pero tienen propósitos y niveles de abstracción diferentes. Aquí está la comparación clara y descriptiva entre ambos:

1. Kubernetes Service
¿Qué es?
Un Service es un recurso nativo de Kubernetes que expone un conjunto de pods al tráfico interno o externo al clúster. Actúa como un balanceador de carga para acceder a aplicaciones o microservicios.

Características principales:
Propósito: Proporciona una dirección IP estable y un punto de acceso para un conjunto de pods seleccionados mediante etiquetas.
Scope: Específico del clúster; opera directamente sobre pods en Kubernetes.
Tipos de Servicios:
ClusterIP: Accesible solo dentro del clúster.
NodePort: Expone el servicio en un puerto estático en cada nodo del clúster.
LoadBalancer: Expone el servicio públicamente usando un balanceador de carga de la nube subyacente.
ExternalName: Redirige a un nombre DNS externo.
Ejemplo de un Service:
yaml
Copy code
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: LoadBalancer
En este ejemplo:

my-service se asocia con los pods etiquetados como app: my-app.
Expone el tráfico externo al puerto 80 y lo redirige al puerto 8080 de los pods.
2. Istio VirtualService
¿Qué es?
Un VirtualService es un recurso de Istio (no nativo de Kubernetes) que define cómo se enruta el tráfico hacia los servicios dentro de una malla de servicios. Proporciona capacidades avanzadas de gestión de tráfico.

Características principales:
Propósito: Controla el tráfico a nivel de aplicación dentro de la malla de servicios Istio.
Scope: Se aplica a servicios manejados por Istio; se integra con Gateways y DestinationRules.
Funciones avanzadas:
Reglas de enrutamiento (basadas en encabezados, rutas o cookies).
Estrategias de despliegue (canary, blue/green).
Retries, timeouts, y circuit breakers.
Modificación de encabezados y URI.
Ejemplo de un VirtualService:
yaml
Copy code
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: my-virtualservice
spec:
  hosts:
  - my-service
  gateways:
  - my-gateway
  http:
  - match:
    - uri:
        prefix: /api
    route:
    - destination:
        host: my-service
        port:
          number: 8080
En este ejemplo:

Redirige solicitudes que coincidan con /api al servicio my-service en el puerto 8080.
Depende de un Gateway Istio para exponer el tráfico.
Diferencias clave
Característica	Service	VirtualService
Nativo de Kubernetes	Sí	No (requiere Istio u otra malla de servicio).
Propósito	Balanceo de carga y descubrimiento de servicios en el clúster.	Enrutamiento avanzado y gestión de tráfico.
Enrutamiento	Simple: redirige al puerto de los pods asociados.	Avanzado: basado en URI, encabezados, cookies, etc.
Exposición	Puede exponer servicios al exterior usando LoadBalancer o NodePort.	Controla el tráfico dentro de la malla de servicios.
Compatibilidad	Funciona sin malla de servicios.	Depende de Istio o equivalente.
Configuraciones avanzadas	No (timeouts, retries requieren otras herramientas).	Sí (timeouts, retries, balanceo avanzado).
Resumen
Service: Se usa para exponer y conectar aplicaciones dentro o fuera del clúster de Kubernetes. Es fundamental para el funcionamiento básico de Kubernetes.
VirtualService: Ofrece un control más granular y avanzado sobre el tráfico, pero requiere una malla de servicios como Istio.
Si estás trabajando con Kubernetes puro, usarás Services. Si usas una malla de servicios como Istio, entonces el VirtualService será útil para un enrutamiento más sofisticado.
