# script en Bash utilizando kubectl para conectarte al clúster de AKS y exportar un ConfigMap a un archivo CSV.

```
#!/bin/bash

# Configuración inicial
NAMESPACE="default"  # Cambia al namespace de tu ConfigMap
CONFIGMAP_NAME="mi-configmap"  # Cambia al nombre de tu ConfigMap
OUTPUT_FILE="configmap.csv"  # Nombre del archivo CSV de salida

# Verifica si kubectl está configurado
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl no está instalado o no está en el PATH."
    exit 1
fi

# Obtiene el ConfigMap en formato JSON
CONFIGMAP_DATA=$(kubectl get configmap "$CONFIGMAP_NAME" -n "$NAMESPACE" -o json)

# Verifica si el ConfigMap existe
if [ -z "$CONFIGMAP_DATA" ]; then
    echo "Error: No se encontró el ConfigMap $CONFIGMAP_NAME en el namespace $NAMESPACE."
    exit 1
fi

# Extrae las claves y valores del ConfigMap
echo "Key,Value" > "$OUTPUT_FILE"  # Escribe el encabezado del CSV
echo "$CONFIGMAP_DATA" | jq -r '.data | to_entries[] | "\(.key),\(.value)"' >> "$OUTPUT_FILE"

# Verifica si la exportación fue exitosa
if [ $? -eq 0 ]; then
    echo "ConfigMap exportado exitosamente a $OUTPUT_FILE"
else
    echo "Error al exportar el ConfigMap a CSV."
    exit 1
fi
```
# Explicación del Script

Configuración inicial:

Especifica el namespace y el nombre del ConfigMap que deseas exportar.
Define el archivo de salida (configmap.csv).
Verificación de herramientas:

Asegúrate de que kubectl esté instalado y disponible.
Obtención del ConfigMap:

Usa kubectl get configmap con la opción -o json para obtener los datos del ConfigMap en formato JSON.
Extracción de datos:

Usa jq para procesar los datos JSON y extraer las claves y valores, escribiéndolos en formato CSV.
Archivo CSV de salida:

Se crea un archivo con las columnas Key y Value, donde cada fila contiene las claves y valores del ConfigMap.
Ejecución
Guarda el script como export_configmap.sh y hazlo ejecutable:

chmod +x export_configmap.sh
Ejecuta el script:

./export_configmap.sh
El archivo configmap.csv se generará en el directorio actual.

Requisitos
Herramientas necesarias:
kubectl: Para interactuar con el clúster de Kubernetes.
jq: Para procesar los datos JSON (puedes instalarlo con sudo apt install jq en Ubuntu o brew install jq en macOS).
Ejemplo de salida (configmap.csv)
Key,Value
clave1,valor1
clave2,valor2
...
