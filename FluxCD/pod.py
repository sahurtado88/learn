import subprocess
import json

# Obtener todos los nodos del clúster
cmd_get_nodes = "kubectl get nodes -o json"
output = subprocess.check_output(cmd_get_nodes, shell=True, text=True)
data = json.loads(output)

# Filtrar los nodos cuyo nombre empieza con "linuxnp-"
nodes = [node["metadata"]["name"] for node in data.get("items", []) if node["metadata"]["name"].startswith("linuxnp-")]

if not nodes:
    print("No se encontraron nodos que comiencen con 'linuxnp-'. Saliendo...")
    exit(0)

print(f"Nodos filtrados: {nodes}")

# Procesar cada nodo filtrado
for node_name in nodes:
    print(f"Procesando nodo: {node_name}")

    # Obtener los pods en el nodo
    cmd_get_pods = f'kubectl get pods --all-namespaces -o json --field-selector spec.nodeName={node_name}'
    output = subprocess.check_output(cmd_get_pods, shell=True, text=True)
    pod_data = json.loads(output)

    # Obtener los namespaces donde hay pods en el nodo
    namespaces = set(pod["metadata"]["namespace"] for pod in pod_data.get("items", []))

    if not namespaces:
        print(f"No hay pods en el nodo {node_name}.")
        continue

    # Escalar a 0 los deployments y statefulsets en los namespaces afectados
    for ns in namespaces:
        print(f"Escalando a 0 en namespace: {ns}")
        subprocess.run(f"kubectl scale deployment --all --replicas=0 -n {ns}", shell=True)
        subprocess.run(f"kubectl scale statefulset --all --replicas=0 -n {ns}", shell=True)

print("Escalado completado en todos los nodos filtrados.")
