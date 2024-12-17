import pandas as pd

# Configura el nombre del archivo CSV y la columna donde se encuentran los nombres de las alertas
input_csv = 'alertas.csv'  # Nombre del archivo CSV de entrada
output_csv = 'alertas_clasificadas.csv'  # Nombre del archivo CSV de salida
alert_column = 'nombre_alerta'  # Nombre de la columna que contiene el nombre de las alertas

# Lista de palabras clave a buscar en los nombres de alerta
keywords = ['System Manager', 'Kubernetes']

# Leer el archivo CSV
df = pd.read_csv(input_csv)

# Asegurar que la columna de nombre de alerta esté en texto
df[alert_column] = df[alert_column].astype(str)

# Crear una nueva columna para cada palabra clave
for keyword in keywords:
    # Nombre de la columna basado en la palabra clave (eliminando espacios y convirtiendo a minúsculas)
    column_name = keyword.replace(" ", "_").lower()
    # Marcar con 1 si la palabra clave está en el nombre de la alerta, 0 si no
    df[column_name] = df[alert_column].str.contains(keyword, case=False, na=False).astype(int)

# Guardar el archivo CSV con las nuevas columnas
df.to_csv(output_csv, index=False)

print(f"Archivo guardado como '{output_csv}' con las columnas adicionales para las palabras clave.")
