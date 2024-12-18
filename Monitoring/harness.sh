#!/bin/bash

# Validation of the number of arguments provided
if [ "$#" -ne 8 ]; then
  echo "Uso: $0 <API_KEY> <ACCOUNT> <ORGANIZATION> <PROJECT> <PIPELINE> <STATUS> <ENVIRONMENT> <PAGERDUTY KEY>"
  exit 1
fi

# Asignación de variables
API_KEY=$1
ACCT=$2
ORG=$3
PROJ=$4
PIPELINE=$5
STATUS=$6
ENVIRONMENT=$7
PD=$8

# Obtaining the current time and the time 30 minutes ago
NOW=$(date +%s%3N) # Time Unix in miliseconds
MINUX=$((NOW - 3600000)) # 30 minutes ago
#MINUX=1733118000

# Reusable functions
function fetch_pipeline_data {
  local status=$1
  local output_file=$2
  
  curl -i -X POST   "https://app.harness.io/pipeline/api/pipelines/execution/summary?accountIdentifier=$ACCT&orgIdentifier=$ORG&projectIdentifier=$PROJ&&pipelineIdentifier=$PIPELINE&page=0&size=10&showAllExecutions=false&branch=main&getDefaultFromOtherRepo=true&status=$status"   -H 'Content-Type: application/json'   -H "x-api-key: $API_KEY"   -d '{
        "filterType": "PipelineExecution"
  }' > "$output_file"
  
  sed -i '1,8d' "$output_file" 

}

function extract_pipeline_info {
  local input_file=$1
  local output_file=$2
  local jq_filter=$3 
  echo "Enviando el siguiente JSON a PagerDuty:"
  echo "$input_file" | jq .
  jq -r -c "$jq_filter" "$input_file" > "$output_file"
}

function notify_pagerduty {
  local environment=$1
  local pipeline=$2
  local output=$3
  local pd=$4
  local cluster=$5
  local status=$6
  
  # Remove control characters from $output
  output=$(echo "$output" | tr -d '\n' | tr -d '\r')
 
  # Create JSON using jq to avoid formatting errors
  DATA=$(jq -n \
    --arg cluster "$cluster" \
    --arg status "$status" \
    --arg summary "Pipeline $PIPELINE in $ENVIRONMENT environment in cluster $cluster ended in $status status validate error and re-execute if it is necessary" \
    --arg source "azure.aks" \
    --arg severity "critical" \
    --arg component "Harness" \
    --arg group "prod-ubuntu-eo" \
    --arg class "QUERY CRITICAL: select * from products" \
    --arg environment "$environment" \
    --arg pipeline "$pipeline" \
    --arg expired "$output" \
    --arg routing_key "$pd" \
    --arg client "Manticore Automation" \
    --arg client_url "https://portal.azure.com" \
    '{
      payload: {
        summary: $summary,
        source: $source,
        severity: $severity,
        component: $component,
        group: $group,
        class: $class,
        custom_details: {
          Environment: $environment,
          Pipeline: $pipeline,
          Harnes_Pipelines_Expired: $expired
        }
      },
      contexts: [],
      routing_key: $routing_key,
      event_action: "trigger",
      client: $client,
      client_url: $client_url
    }'
  )

  # Print JSON for debugging
  #echo "Enviando el siguiente JSON a PagerDuty:"
  #echo "$DATA" | jq .


  # Send notification to PagerDuty
  curl --request POST --header 'Content-Type: application/json' --data "$DATA" --url 'https://events.pagerduty.com/v2/enqueue'
}

# --- Status Expired ---

fetch_pipeline_data "$STATUS" "data$PIPELINE.json"
extract_pipeline_info "data$PIPELINE.json" "Expired.txt" '.data.content[] | {starttime: .startTs, planexecutionID: .planExecutionId, infra: .moduleInfo.cd.infrastructureNames[]}'

echo "Validation from $(date -d @${MINUX:0:10}) to $(date -d @${NOW:0:10})"

output=$(awk -v MINUX="$MINUX" -v PIPELINE="$PIPELINE" -F'[,:}]' '$2 > MINUX {print "https://app.harness.io/ng/account/vrst0PgwRnOIeii0a2inKg/all/orgs/default/projects/FTDS/pipelines/" PIPELINE "/executions/" $4 "\n"}' Expired.txt | tr -d '"')
cluster=$(awk -F'[,:}]' 'NR==1 { print $6 }' Expired.txt | tr -d '"')

if [ -n "$output" ]; then
  output="${output//$'\n'/\\n}"
  
  custom_details="{
    \"Environment\": \"$ENVIRONMENT\",
    \"Pipeline\": \"$PIPELINE\",
    \"Harnes_Pipelines_Expired\": \"$output\"
  }"
  
  notify_pagerduty "$ENVIRONMENT" "$PIPELINE"  "$output" "$PD" "$cluster" "$STATUS"
else
  echo "Pipeline $PIPELINE not found: in status $STATUS"
fi

# --- Status Aborted ---

fetch_pipeline_data "Aborted" "dataaborted$PIPELINE.json"
extract_pipeline_info "dataaborted$PIPELINE.json" "aborted.txt" '.data.content[] | {starttime: .startTs, planexecutionID: .planExecutionId, infra: .moduleInfo.cd.infrastructureNames[]}'

echo "Validation from $(date -d @${MINUX:0:10}) to $(date -d @${NOW:0:10})"

output=$(awk -v MINUX="$MINUX" -v PIPELINE="$PIPELINE" -F'[,:}]' '$2 > MINUX {print "https://app.harness.io/ng/account/vrst0PgwRnOIeii0a2inKg/all/orgs/default/projects/FTDS/pipelines/" PIPELINE "/executions/" $4 ", Cluster " $6 "\n"}' aborted.txt | tr -d '"')
cluster=$(awk -F'[,:}]' 'NR==1 { print $6 }' aborted.txt | tr -d '"')
state="Aborted"

if [ -n "$output" ]; then
  output="${output//$'\n'/\\n}"
  #cluster="${cluster//$'\n'/\\n}"
  
  custom_details="{
    \"Environment\": \"$ENVIRONMENT\",
    \"Pipeline\": \"$PIPELINE\",
    \"Harnes_Pipelines_Expired\": \"$output\",
    \"Cluster\": \"$cluster\"
  }"
  
  notify_pagerduty "$ENVIRONMENT" "$PIPELINE"  "$output" "$PD" "$cluster" "$state"
else
  echo "Pipeline $PIPELINE not found: in status Aborted"
fi

# --- Status "Failed" ---

fetch_pipeline_data "Failed" "dataFailed$PIPELINE.json"
extract_pipeline_info "dataFailed$PIPELINE.json" "Failed.txt" '.data.content[] | {starttime: .startTs, planexecutionID: .planExecutionId, infra: .moduleInfo.cd.infrastructureNames[]}'

echo "Validation from $(date -d @${MINUX:0:10}) to $(date -d @${NOW:0:10})"

output=$(awk -v MINUX="$MINUX" -v PIPELINE="$PIPELINE" -F'[,:}]' '$2 > MINUX {print "https://app.harness.io/ng/account/vrst0PgwRnOIeii0a2inKg/all/orgs/default/projects/FTDS/pipelines/" PIPELINE "/executions/" $4 ", Cluster " $6 "\n"}' Failed.txt | tr -d '"')
cluster=$(awk -F'[,:}]' 'NR==1 { print $6 }' Failed.txt | tr -d '"')
state="Failed"
if [ -n "$output" ]; then
  output="${output//$'\n'/\\n}"
  #cluster="${cluster//$'\n'/\\n}"
  
  custom_details="{
    \"Environment\": \"$ENVIRONMENT\",
    \"Pipeline\": \"$PIPELINE\",
    \"Harnes_Pipelines_Failed\": \"$output\",
    \"Cluster\": \"$cluster\"
  }"
  
  notify_pagerduty "$ENVIRONMENT" "$PIPELINE"  "$output" "$PD" "$cluster" "$state"
else
  echo "Pipeline $PIPELINE not found: in status Failed"
fi