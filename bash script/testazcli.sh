#! /bin/bash
CLIENTID=$1
CLIENTSECRET=$2
SUBSCRIPTIONID=$3
PD=$4

#Login to Azure Subscription
az login --service-principal --username $CLIENTID --password $CLIENTSECRET --tenant "855b093e-7340-45c7-9f0c-96150415893e"
az account set --subscription $SUBSCRIPTIONID

#Define the vector of the cluster that I am going to check
clusters_check=( 001 002 004 007 009 012 015 )
#Getting a List of all AKSs deployed into the Azure subscription
AKSLIST=$(az aks list --output json)
#Filtering AKSs by Running and its name convention (starting by ftds)
AKSRUNNING=$(echo "$AKSLIST" | jq -c '.[] | select((.powerState.code == "Running") and (.name | test("ftds*"))) |{clusterName: .name, resourceGroup: .resourceGroup, power: .powerState.code}')

#Login to every AKS after being filtered
for AKS in $AKSRUNNING
do
    #Getting AKS name
    CLUSTER=$(echo  $AKS | awk -F ":" '{print $2}' | awk -F "," '{print $1}' | tr -d '"')
    # Get the cluster name
    CLUSTER_NUM=$(echo $CLUSTER | grep -o '[0-9]\+')

    #verified if the cluster names are right
    if [[ " ${clusters_check[@]} " =~ " ${CLUSTER_NUM} " ]]; then
        echo "Verificando cluster: $CLUSTER"
        #Getting Azure Resource Group
        RG=$(echo  $AKS | awk -F ":" '{print $3}'  | awk -F "," '{print $1}' | tr -d '"' )
        #Status cluster
        STATUS=$(echo  $AKS | awk -F ":" '{print $4}'  | awk -F "," '{print $1}' | tr -d '"' )
        #login to every AKS (one by one)
        az aks get-credentials --resource-group $RG --name $CLUSTER --overwrite-existing
        #Getting the pods of ra-monitoring
        PODS=$(kubectl get pod -n ra-monitoring | grep -E "^loki|^thanos|^prometheus|^promtail|^tempo" |  awk '{print $1, $3}')
        #Getting the deployments
        DEPLOYMENTS=$(kubectl get deployments -n ra-monitoring | grep -E "^loki|^thanos|^prometheus|^tempo" | awk '{print $1, $2, $3}')
        #Getting the statefulset
        STATEFUL=$(kubectl get statefulset -n ra-monitoring | awk '{print $1, $2, $3}')
    
    
        #First approach to the clusters
        if [[ $(echo "$PODS" | grep -v -E 'Running|Completed|PodInitializing|ContainerCreating' || echo "$STATEFUL" | grep -E ' 0/1|0/2|1/2|0/3|1/3|2/3|0/0' || echo "$DEPLOYMENTS" | grep -E ' 0/1|0/2|1/2|0/3|1/3|2/3|0/0') ]];
        then 
        
            sleep 180
        fi
    
        #Getting the pods of ra-monitoring
        PODS=$(kubectl get pod -n ra-monitoring | grep -E "^loki|^thanos|^prometheus|^promtail|^tempo" |  awk '{print $1, $3}')
        #Getting the deployments
        DEPLOYMENTS=$(kubectl get deployments -n ra-monitoring | grep -E "^loki|^thanos|^prometheus|^tempo" | awk '{print $1, $2, $3}')
        #Getting the statefulset
        STATEFUL=$(kubectl get statefulset -n ra-monitoring | awk '{print $1, $2, $3}')
        #alerting pods
        if [[ $(echo "$PODS" | grep -v -E 'Running|Completed|PodInitializing|ContainerCreating' || echo "$STATEFUL" | grep -E ' 0/1|0/2|1/2|0/3|1/3|2/3|0/0' || echo "$DEPLOYMENTS" | grep -E ' 0/1|0/2|1/2|0/3|1/3|2/3|0/0') ]]; 
        then
            P=$(echo "$PODS" | grep -v -E 'Running|Completed|PodInitializing|ContainerCreating')
            S=$(echo "$STATEFUL" | grep -E ' 0/1|0/2|1/2|0/3|1/3|2/3|0/0' | awk '{print $1, $2}')
            D=$(echo "$DEPLOYMENTS" | grep -E ' 0/1|0/2|1/2|0/3|1/3|2/3|0/0' | awk '{print $1, $2}')
            read -ra P_array <<< "$P"
            read -ra S_array <<< "$S"
            read -ra D_array <<< "$D"
            DATA="{
                                    \"payload\": {
                                            \"summary\": \"Cluster $CLUSTER have issues with Pods/Deployments/Statefulsets from ra-monitoring namespace with Status different from Running\",
                                            \"source\": \"azure.aks\",
                                            \"severity\": \"critical\", 
                                            \"component\": \"Azure AKS\",
                                            \"group\": \"prod-ubuntu-eo\",
                                            \"class\": \"QUERY CRITICAL: select * from products\",
                                            \"custom_details\": {
                                                    \"AKS Cluster\": \"$CLUSTER\",
                                                    \"Resource Group\": \""$RG"\",
                                                    \"Pods afeccted\": \"$P_array\",
                                                    \"Deployments afeccted\": \"$D_array\",
                                                    \"Stateful afeccted\": \"$S_array\",
                                                    \"Workaround\": \"https://rockwellautomation.atlassian.net/wiki/spaces/CS/pages/3609264585/AKS+Troubleshooting\"
                                                }
                                },
                                \"contexts\": [],
                                \"routing_key\": \"$PD\",
                                \"event_action\": \"trigger\",
                                \"client\": \"Manticore Automation\",
                                \"client_url\": \"https://portal.azure.com\"
                            }"
            curl --request POST --header 'Content-Type: application/json' --data "$DATA" --url 'https://events.pagerduty.com/v2/enqueue'
        fi
    fi
done
