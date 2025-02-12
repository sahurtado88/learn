import subprocess
import json
import sys
 
node_name = sys.argv[1] if len(sys.argv) >1 else exit("uso python pod.py <node-name>")
 
cmd_get_pods = f'kubectl get pods --all-namespaces -o json --field-selector spec.nodeName={node_name}'
output = subprocess.check_output(cmd_get_pods,shell=True, text=True)
data = json.loads(output)
 
namespaces = set(pod["metadata"]["namespace"] for pod in data.get("items", []))
for ns in namespaces:
    print(f"escalando a 0 en namespaces: {ns}")
    subprocess.run(f"kubectl scale deployment --all --replicas=0  -n {ns}", shell=True)
    subprocess.run(f"kubectl scale statefulset --all --replicas=0  -n {ns}", shell=True)
 
print("Escalado completado")