#!/bin/bash

# Validación de la cantidad de argumentos proporcionados
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

# Obtención de la hora actual y la hora de hace 30 minutos
NOW=$(date +%s%3N) # Tiempo Unix en milisegundos
MINUX=$((NOW - 1800000)) # 30 minutos antes de NOW

# Funciones reutilizables
function fetch_pipeline_data {
  local status=$1
  local output_file=$2
  
  curl -s -X POST "https://app.harness.io/pipeline/api/pipelines/execution/summary?accountIdentifier=$ACCT&orgIdentifier=$ORG&projectIdentifier=$PROJ&pipelineIdentifier=$PIPELINE&page=0&size=10&showAllExecutions=false&branch=main&getDefaultFromOtherRepo=true&status=$status" \
    -H 'Content-Type: application/json' \
    -H "x-api-key: $API_KEY" \
    -d '{"filterType": "PipelineExecution"}' > "$output_file"
  
  sed -i '1,8d' "$output_file" 
}

function extract_pipeline_info {
  local input_file=$1
  local output_file=$2
  local jq_filter=$3
  
  jq -r -c "$jq_filter" "$input_file" > "$output_file"
}

function notify_pagerduty {
  local summary=$1
  local custom_details=$2
  
  local data="{
    \"payload\": {
      \"summary\": \"$summary\",
      \"source\": \"azure.aks\",
      \"severity\": \"critical\",
      \"component\": \"Harness\",
      \"group\": \"prod-ubuntu-eo\",
      \"class\": \"QUERY CRITICAL: select * from products\",
      \"custom_details\": $custom_details
    },
    \"contexts\": [],
    \"routing_key\": \"$PD\",
    \"event_action\": \"trigger\",
    \"client\": \"Manticore Automation\",
    \"client_url\": \"https://portal.azure.com\"
  }"
  
  curl --request POST --header 'Content-Type: application/json' --data "$data" --url 'https://events.pagerduty.com/v2/enqueue'
}

# --- Proceso para el estado inicial (STATUS) ---

fetch_pipeline_data "$STATUS" "data$PIPELINE.json"
extract_pipeline_info "data$PIPELINE.json" "test.txt" '.data.content[] | {starttime: .startTs, planexecutionID: .planExecutionId}'

echo "Validación desde $(date -d @${MINUX:0:10}) hasta $(date -d @${NOW:0:10})"

output=$(awk -v MINUX="$MINUX" -v PIPELINE="$PIPELINE" -F'[,:}]' '$2 > MINUX {print "https://app.harness.io/ng/account/vrst0PgwRnOIeii0a2inKg/all/orgs/default/projects/FTDS/pipelines/" PIPELINE "/executions/" $4 "\n"}' test.txt | tr -d '"')

if [ -n "$output" ]; then
  output="${output//$'\n'/\\n}"
  
  custom_details="{
    \"Environment\": \"$ENVIRONMENT\",
    \"Pipeline\": \"$PIPELINE\",
    \"Harnes_Pipelines_Expired\": \"$output\"
  }"
  
  notify_pagerduty "Pipeline $PIPELINE terminó en estado $STATUS. Validar y re-ejecutar si es necesario" "$custom_details"
else
  echo "No se encontró el Pipeline: $PIPELINE en estado $STATUS"
fi

# --- Proceso para el estado "Aborted" ---

fetch_pipeline_data "Aborted" "dataaborted$PIPELINE.json"
extract_pipeline_info "dataaborted$PIPELINE.json" "aborted.txt" '.data.content[] | {starttime: .startTs, planexecutionID: .planExecutionId, infra: .moduleInfo.cd.infrastructureNames[]}'

echo "Validación desde $(date -d @${MINUX:0:10}) hasta $(date -d @${NOW:0:10})"

output=$(awk -v MINUX="$MINUX" -v PIPELINE="$PIPELINE" -F'[,:}]' '$2 > MINUX {print "https://app.harness.io/ng/account/vrst0PgwRnOIeii0a2inKg/all/orgs/default/projects/FTDS/pipelines/" PIPELINE "/executions/" $4 ", Cluster " $6 "\n"}' aborted.txt | tr -d '"')

cluster=$(awk -F'[,:}]' 'NR==1 { print $6 }' aborted.txt | tr -d '"')

if [ -n "$output" ]; then
  output="${output//$'\n'/\\n}"
  cluster="${cluster//$'\n'/\\n}"
  
  custom_details="{
    \"Environment\": \"$ENVIRONMENT\",
    \"Pipeline\": \"$PIPELINE\",
    \"Harnes_Pipelines_Expired\": \"$output\",
    \"Cluster\": \"$cluster\"
  }"
  
  notify_pagerduty "Pipeline $PIPELINE en entorno $ENVIRONMENT en el clúster $cluster terminó en estado ABORTED. Validar y re-ejecutar si es necesario" "$custom_details"
else
  echo "No se encontró el Pipeline: $PIPELINE en estado Aborted"
fi


function notify_pagerduty {
  local environment=$1
  local pipeline=$2
  local output=$3
  local pd=$4
  
  # Eliminar caracteres de control de $output
  output=$(echo "$output" | tr -d '\n' | tr -d '\r')
  
  # Crear el JSON usando jq para evitar errores de formato
  DATA=$(jq -n \
    --arg summary "Pipeline $pipeline ended in expired status validate error and re-execute if it is necessary" \
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

  # Imprimir el JSON para depuración
  echo "Enviando el siguiente JSON a PagerDuty:"
  echo "$DATA" | jq .

  # Enviar la notificación a PagerDuty
  curl --request POST --header 'Content-Type: application/json' --data "$DATA" --url 'https://events.pagerduty.com/v2/enqueue'
}
