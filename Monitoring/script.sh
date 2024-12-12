#!/bin/bash

if [ "$#" -ne 8 ]; then
  echo "use: $0 <API_KEY> <ACCOUNT> <ORGANIZATION> <PROJECT> <PIPELINE> <STATUS> <ENVIRONMENT> <PAGERDUTY KEY>"
  exit 1
fi

API_KEY=$1
ACCT=$2
ORG=$3
PROJ=$4
PIPELINE=$5
STATUS=$6
ENVIRONMENT=$7
PD=$8

NOW=$(date +%s%3N) #unix time miliseconds
MINUX=$((NOW - 1800000)) # 30 minutes before now

curl -i -X POST   "https://app.harness.io/pipeline/api/pipelines/execution/summary?accountIdentifier=$ACCT&orgIdentifier=$ORG&projectIdentifier=$PROJ&&pipelineIdentifier=$PIPELINE&page=0&size=10&showAllExecutions=false&branch=main&getDefaultFromOtherRepo=true&status=$STATUS"   -H 'Content-Type: application/json'   -H "x-api-key: $API_KEY"   -d '{
        "filterType": "PipelineExecution"
  }' > data$PIPELINE.json

sed -i '1,8d' data$PIPELINE.json 
echo data$PIPELINE.json | jq -c -r '.data.content[] | {starttime: .startTs, planexecutionID : .planExecutionId}' data$PIPELINE.json > test.txt

#MINUX=1733118000

echo "Validation from "$(date -d @$(echo $MINUX | cut -c1-10)) " until "$(date -d @$(echo $NOW | cut -c1-10))
output=$(awk -v MINUX="$MINUX" -v PIPELINE="$PIPELINE" -F'[,:}]' '$2 > MINUX {print "https://app.harness.io/ng/account/vrst0PgwRnOIeii0a2inKg/all/orgs/default/projects/FTDS/pipelines/" PIPELINE "/executions/" $4 "\n"}' test.txt | tr -d '"')
if [ -n "$output" ]; then
        output="${output//$'\n'/\\n}"
        echo -e $output
        DATA="{
                                \"payload\": {
                                        \"summary\": \"Pipeline $PIPELINE ended in expired status validate error and re-execute if it is necessary\",
                                        \"source\": \"azure.aks\",
                                        \"severity\": \"critical\", 
                                        \"component\": \"Harness\",
                                        \"group\": \"prod-ubuntu-eo\",
                                        \"class\": \"QUERY CRITICAL: select * from products\",
                                        \"custom_details\": {
                                                \"Environment\": \"$ENVIRONMENT\",
                                                \"Pipeline\": \""$PIPELINE"\",
                                                \"Harnes_Pipelines_Expired\": \"$output\"
                                            }
                            },
                            \"contexts\": [],
                            \"routing_key\": \"$PD\",
                            \"event_action\": \"trigger\",
                            \"client\": \"Manticore Automation\",
                            \"client_url\": \"https://portal.azure.com\"
                        }"
        curl --request POST --header 'Content-Type: application/json' --data "$DATA" --url 'https://events.pagerduty.com/v2/enqueue'

else
    echo "NOT found Pipeline: "$PIPELINE" in "$STATUS" state" 
fi


curl -i -X POST   "https://app.harness.io/pipeline/api/pipelines/execution/summary?accountIdentifier=$ACCT&orgIdentifier=$ORG&projectIdentifier=$PROJ&&pipelineIdentifier=$PIPELINE&page=0&size=10&showAllExecutions=false&branch=main&getDefaultFromOtherRepo=true&status=Aborted"   -H 'Content-Type: application/json'   -H "x-api-key: $API_KEY"   -d '{
        "filterType": "PipelineExecution"
  }' > dataaborted$PIPELINE.json

sed -i '1,8d' dataaborted$PIPELINE.json 
echo dataaborted$PIPELINE.json | jq -r -c '.data.content[] | {starttime: .startTs, planexecutionID : .planExecutionId, infra: .moduleInfo.cd.infrastructureNames[]}' dataaborted$PIPELINE.json > aborted.txt

#MINUX=1733118000

echo "Validation from "$(date -d @$(echo $MINUX | cut -c1-10)) " until "$(date -d @$(echo $NOW | cut -c1-10))
output=$(awk -v MINUX="$MINUX" -v PIPELINE="$PIPELINE" -F'[,:}]' '$2 > MINUX {print "https://app.harness.io/ng/account/vrst0PgwRnOIeii0a2inKg/all/orgs/default/projects/FTDS/pipelines/" PIPELINE "/executions/" $4 , "Cluster " $6 "\n"}' aborted.txt | tr -d '"')
cluster=$(awk -F'[,:}]' 'NR==1 { print $6 }' aborted.txt | tr -d '"')
if [ -n "$output" ]; then
        output="${output//$'\n'/\\n}"
        cluster="${cluster//$'\n'/\\n}"
        echo -e $output
        echo -e $cluster
        DATA="{
                                \"payload\": {
                                        \"summary\": \"Pipeline $PIPELINE in $ENVIRONMENT environment in cluster $cluster ended in ABORTED status validate error and re-execute if it is necessary\",
                                        \"source\": \"azure.aks\",
                                        \"severity\": \"critical\", 
                                        \"component\": \"Harness\",
                                        \"group\": \"prod-ubuntu-eo\",
                                        \"class\": \"QUERY CRITICAL: select * from products\",
                                        \"custom_details\": {
                                                \"Environment\": \"$ENVIRONMENT\",
                                                \"Pipeline\": \""$PIPELINE"\",
                                                \"Harnes_Pipelines_Expired\": \"$output\"
                                            }
                            },
                            \"contexts\": [],
                            \"routing_key\": \"$PD\",
                            \"event_action\": \"trigger\",
                            \"client\": \"Manticore Automation\",
                            \"client_url\": \"https://portal.azure.com\"
                        }"
        curl --request POST --header 'Content-Type: application/json' --data "$DATA" --url 'https://events.pagerduty.com/v2/enqueue'

else
    echo "NOT found Pipeline: "$PIPELINE" in Aborted state" 
fi

