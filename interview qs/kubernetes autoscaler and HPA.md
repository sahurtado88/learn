# Autosclaer



## OIDC

## POd identity

- damonset add on pod-identity
- IAM role clusterautoscaler pricnipal service pods.eks.amazon.com
- policy allow autoscaling group
- attach policy to role
- associate with service account
- deploy de helm char of  clusterautoscaler
- depnd on metric server

## HPA
- metric server CPU and/or memory (not instlaled in eks, installed in aks an gke)
- pods must have the resources request (unkown si no esta definido)
- horizontal pod auto scaler

not set replicas in deployment y stefulset if you use gitops gitops or flux

if you use custom metric you need promethues  and promethues operator
prometheus adpater 

### VPA 

initial

off
vpa controller need installed
vpa for statefull

# KEDA scale kafka other compoenents

deploy controller

# KArpenter



https://www.youtube.com/watch?v=hsJ2qtwoWZw

