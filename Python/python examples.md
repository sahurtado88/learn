If  is odd, print Weird
If  is even and in the inclusive range of  to , print Not Weird
If  is even and in the inclusive range of  to , print Weird
If  is even and greater than , print Not Weird

```
def main():
    n = int(input("Ingrese un número entero: "))

    if n % 2 != 0:
        print("Weird")
    else:
        if n >= 2 and n <= 5:
            print("Not Weird")
        elif n >= 6 and n <= 20:
            print("Weird")
        elif n > 20:
            print("Not Weird")

if __name__ == "__main__":
    main()
```
_________________________________

#the floor division // rounds the result down to the nearest whole number
```
if __name__ == '__main__':
    a = int(input())
    b = int(input())
    print(a//b) # 1
    print(a/b) #1.333333

```
___________________________

The list of non-negative integers that are less than  is . Print the square of each number on a separate line.

The range() function returns a sequence of numbers, starting from 0 by default, and increments by 1 (by default), and stops before a specified number

range(start, stop, step)

```
if __name__ == '__main__':
    n = int(input())
    for i in range(n):
        print(i ** 2)
```
_________________________

año es bisisesto

```
def is_leap(year):
    leap = False
    
    if year % 4 == 0:  # Los años divisibles por 4 pueden ser bisiestos
        if year % 100 == 0:  # Si es divisible por 100, debe ser divisible por 400 para ser bisiesto
            if year % 400 == 0:
                leap= True
            else:
                leap= False
        else:
            leap= True
    else:
        leap= False
    
    return leap

year = int(input())
```
_________________________

Sin embargo, puedes cambiar este comportamiento y especificar cualquier otro caracter o cadena de caracteres para que sea impreso al final de la salida. Aquí hay algunas opciones comunes para end:

end="": No imprime ningún carácter al final de la salida. Esto hace que el próximo print() comience exactamente donde termina la salida actual.

end=" ": Imprime un espacio en blanco al final de la salida. Esto es útil cuando quieres separar los argumentos de salida de diferentes print() sin un espacio en blanco adicional.

end="\t": Imprime un tabulador al final de la salida. Esto es útil para formatear la salida en columnas.

end="texto personalizado": Puedes especificar cualquier cadena de caracteres que desees imprimir al final de la salida.

En resumen, el parámetro end te permite controlar qué se imprime al final de la llamada a la función print(), lo que te da flexibilidad para formatear la salida según tus necesidades.
```
def print_numbers(n):
    for i in range(1, n + 1):
        print(i, end="")
    print()
```

_______________________________

Given the participants' score sheet for your University Sports Day, you are required to find the runner-up score. You are given  scores. Store them in a list and find the score of the runner-up.

Input Format

The first line contains . The second line contains an array   of  integers each separated by a space.


La expresión map(int, input().split()) se utiliza para convertir una entrada de usuario en una lista de enteros en Python. Aquí está cómo funciona:

input(): Esta función solicita al usuario que ingrese una cadena de texto desde la entrada estándar (generalmente desde el teclado) y devuelve esa cadena.

.split(): Este método se aplica a la cadena devuelta por input() y divide la cadena en palabras separadas por espacios en blanco. Devuelve una lista de cadenas.

map(int, ...): La función map() toma dos argumentos: una función y un iterable. En este caso, la función es int, que convierte cada elemento del iterable en un entero.

Entonces, en conjunto, map(int, input().split()):

Solicita al usuario que ingrese una cadena de números separados por espacios.
Divide esa cadena en palabras, donde cada palabra es un número.
Convierte cada palabra (que es un número en forma de cadena) en un entero.

Utiliza la función set() para eliminar los puntajes duplicados y luego los ordena en orden descendente con sorted() y reverse=True.

```
if __name__ == '__main__':
    n = int(input())
    arr = map(int, input().split())
    scores=list(arr)
    unique_scores = sorted(set(scores), reverse=True)
    
    if len(unique_scores) > 1:
        runner_up_score = unique_scores[1]
    print(runner_up_score)
```
________________________________

Given the names and grades for each student in a class of  students, store them in a nested list and print the name(s) of any student(s) having the second lowest grade.

Note: If there are multiple students with the second lowest grade, order their names alphabetically and print each name on a new line.

```
# Almacenar los nombres y calificaciones de los estudiantes en una lista anidada
students = []
    for _ in range(int(input())):
        name = input()
        score = float(input())
        students.append([name, score])

    # Encontrar la segunda calificación más baja
    scores = sorted(set([student[1] for student in students]))
    second_lowest_score = scores[1]

    # Identificar los estudiantes que tienen la segunda calificación más baja
    second_lowest_students = [student[0] for student in students if student[1] == second_lowest_score]

    # Ordenar los nombres de los estudiantes en orden alfabético
    second_lowest_students.sort()

    # Imprimir los nombres de los estudiantes que tienen la segunda calificación más baja
    for student in second_lowest_students:
        print(student)

```
The provided code stub will read in a dictionary containing key/value pairs of name:[marks] for a list of students. Print the average of the marks array for the student name provided, showing 2 places after the decimal.


```
if __name__ == '__main__':
    n = int(input())
    student_marks = {}
    for _ in range(n):
        name, *line = input().split()
        scores = list(map(float, line))
        student_marks[name] = scores
    query_name = input()
    marks = student_marks[query_name]
    average_marks = sum(marks) / len(marks)
    print("{:.2f}".format(average_marks))
```

_________________________________
You are given three integers  and  representing the dimensions of a cuboid along with an integer  n . Print a list of all possible coordinates given by (i,j,k) on a 3D grid where the sum of i+j+k is not equal to n . Please use list comprehensions rather than multiple loops, as a learning exercise.

Utiliza una lista de comprensión para generar todas las combinaciones posibles de coordenadas (i, j, k) dentro del rango (0, x), (0, y), (0, z) respectivamente.
La expresión [[i, j, k] for i in range(x + 1) for j in range(y + 1) for k in range(z + 1)] itera a través de todas las combinaciones posibles de i, j, y k.
La condición if (i + j + k) != n asegura que solo se agreguen las coordenadas cuya suma de componentes i, j y k no sea igual a n.

Las listas de comprensión, o list comprehensions en inglés, son una característica muy útil de Python que te permite crear listas de manera concisa y elegante.

En Python, puedes usar listas de comprensión para crear listas basadas en iterables como listas, tuplas, rangos, etc. La sintaxis básica de una lista de comprensión es la siguiente:

```
[expresión for elemento in iterable if condición]
```
- expresión: La expresión que se evalúa y se agrega a la lista resultante.
- elemento: Variable que representa cada elemento del iterable.
- iterable: El iterable sobre el cual se está iterando (por ejemplo, una lista, un rango, etc.).
- condición (opcional): Una condición que filtra los elementos antes de que se agreguen a la lista resultante.

Las listas de comprensión son muy útiles porque permiten escribir código más legible y compacto, especialmente cuando necesitas transformar o filtrar elementos de una lista.

Veamos un ejemplo simple para entender mejor cómo funcionan las listas de comprensión:

Supongamos que queremos crear una lista que contenga los cuadrados de los primeros 5 números enteros positivos:

```
squares = [x**2 for x in range(1, 6)]
print(squares)
```


Este código generará la siguiente salida:

```
[1, 4, 9, 16, 25]
```
Aquí, x**2 es la expresión que genera los cuadrados de cada número x en el rango (1, 6) (del 1 al 5). La variable x es el elemento que toma cada valor en el rango. La lista resultante contendrá los cuadrados de esos números.

Es importante destacar que las listas de comprensión pueden ser anidadas y pueden incluir condiciones, lo que las hace muy flexibles y poderosas para generar listas de manera eficiente y legible.

```
x, y, z, n = (int(input()) for _ in range(4))

coordinates = [[i, j, k] for i in range(x + 1) for j in range(y + 1) for k in range(z + 1) if (i + j + k) != n]

print(coordinates)

```


Validar email con REgex
```
import re
pattern = r'^[a-zA-Z][a-zA-Z0-9._-]*@[a-zA-Z]+\.[a-zA-Z]{1,3}$'
n = int(input())
for _ in range(n):
    name, email = input().split()
    if re.match(pattern, email):
        print(name, email)
```

usando email.util

```
import re
import email.utils as emu

for _ in range(int(input())):
    mail = emu.parseaddr(input())
    if re.match(r"^[a-z][\w\-\.]+@[a-z]+\.[a-z]{1,3}$", mail[1]):
        print(emu.formataddr(mail))
```

validar si valores de HEX es valido 

```
import re

for _ in range(int(input())):
    result = re.findall(r"(?<=.)#[a-fA-F0-9]{3,6}", input())
    if result:
        print(*result, sep="\n")
```


averiguar par o impar funcion
```
def check_even_odd(number):

    if number % 2 == 0:

          return "Even"

    else:

          return "Odd" 



print(check_even_odd(7))
```

factoril

```
def factorial(n):

    if n == 0 or n == 1:

        return 1

    else:

        return n * factorial(n - 1)

result = factorial(5)

print("Factorial is", result)
```

# reverse a list


En Python, list[::-1] es una técnica para invertir una lista. Esta notación utiliza el slicing, que es una característica poderosa de Python para acceder a partes de una lista (o cualquier secuencia) utilizando una sintaxis simple y expresiva.

Veamos los componentes de list[::-1]:

list: se refiere a la lista que deseas invertir.
[::]: esta es la notación de slicing en Python. Permite especificar un rango de elementos que quieres extraer de una lista.
Los tres parámetros dentro de los corchetes son los siguientes:

El primer parámetro (en blanco :) representa el inicio del rango.
El segundo parámetro (en blanco :) representa el final del rango.
El tercer parámetro (-1) representa el paso, es decir, la cantidad de elementos que se omiten mientras se recorre la lista. En este caso, -1 significa que se recorre la lista en dirección inversa.
Por lo tanto, list[::-1] indica que estás seleccionando todos los elementos de la lista (::) pero con un paso de -1, lo que significa que se recorre la lista desde el último elemento hasta el primero.

En resumen, list[::-1] devuelve una nueva lista que contiene los mismos elementos que la lista original, pero en orden inverso. Es una manera concisa y efectiva de invertir una lista en Python.

```
List1 = [10,20,30,40,50]

print(List1[::-1])
```

# conteo letras 

```
def string_lengths(strings):

    return [len(s) for s in strings]



words = ["apple", "banana", "orange", "kiwi"]

lengths = string_lengths(words)

print(lengths)
```
_________________________________________

descomprimir archivo y listar objetos

```
import zipfile
import subprocess

def descomprimir_y_ejecutar(nombre_archivo_zip):
    # Descomprimir el archivo zip
    with zipfile.ZipFile(nombre_archivo_zip, 'r') as zip_ref:
        zip_ref.extractall('archivos_descomprimidos')
    
    # Obtener la lista de archivos descomprimidos
    lista_archivos = os.listdir('archivos_descomprimidos')

    # Ejecutar el comando echo con cada nombre de archivo
    for archivo in lista_archivos:
        # Construir el comando echo
        comando_echo = ['echo', f'El nombre del archivo es: {archivo}']
        # Ejecutar el comando en la consola
        subprocess.run(comando_echo, shell=True)

if __name__ == "__main__":
    # Nombre del archivo zip a descomprimir
    nombre_archivo_zip = 'archivo.zip'
    # Llamar a la función para descomprimir y ejecutar el comando echo
    descomprimir_y_ejecutar(nombre_archivo_zip)
```

cmabair replicas en un deployment

```
from kubernetes import client, config

def scale_deployment(namespace, deployment_name, replicas):
    # Cargar la configuración de Kubernetes desde el archivo kubeconfig
    config.load_kube_config()

    # Crear un objeto de cliente para interactuar con el API de Kubernetes
    api_instance = client.AppsV1Api()

    # Definir los parámetros para la actualización del deployment
    body = {
        "spec": {
            "replicas": replicas
        }
    }

    try:
        # Actualizar el deployment
        api_response = api_instance.patch_namespaced_deployment_scale(
            name=deployment_name,
            namespace=namespace,
            body=body
        )
        print("Deployment escala actualizado: %s" % api_response.status.replicas)
    except Exception as e:
        print("Error al actualizar el deployment: %s" % str(e))

# Definir los parámetros del deployment
namespace = "default"  # Namespace donde se encuentra el deployment
deployment_name = "nombre-del-deployment"  # Nombre del deployment que deseas escalar
replicas = 3  # Número de réplicas al que deseas escalar el deployment

# Llamar a la función para escalar el deployment
scale_deployment(namespace, deployment_name, replicas)
```

validar numeros flatantes en una lista

```
def numeros_faltantes_consecutivos(lista):
    # Ordenamos la lista de números
    lista.sort()
    
    # Inicializamos una lista para almacenar los números faltantes
    faltantes = []
    
    # Iteramos a través de la lista para buscar números faltantes
    for i in range(len(lista) - 1):
        # Verificamos si hay números faltantes entre los elementos consecutivos
        if lista[i+1] - lista[i] > 1:
            # Agregamos los números faltantes a la lista
            for j in range(lista[i] + 1, lista[i+1]):
                faltantes.append(j)
    
    return faltantes

# Ejemplo de uso
if __name__ == "__main__":
    # Ingresa la lista de números como entrada
    numeros = input("Ingresa la lista de números separados por espacios: ").split()
    
    # Convierte los números ingresados a enteros
    numeros = [int(num) for num in numeros]
    
    # Llama a la función para encontrar números faltantes consecutivos
    faltantes = numeros_faltantes_consecutivos(numeros)
    
    # Verifica si hay números faltantes
    if len(faltantes) > 0:
        print("Números faltantes consecutivos:", faltantes)
    else:
        print("No hay números faltantes consecutivos.")

```

varios valores repetidos en una tupla

```
def encontrar_indices(tupla, valor):
    """
    Encuentra todos los índices de un valor dado dentro de una tupla.
    
    Args:
    - tupla: La tupla en la que buscar el valor.
    - valor: El valor que se desea encontrar.
    
    Returns:
    - Una lista de índices donde se encuentra el valor.
      Si el valor no se encuentra, devuelve una lista vacía.
    """
    indices = []
    for i, elemento in enumerate(tupla):
        if elemento == valor:
            indices.append(i)
    return indices

# Ejemplo de uso
mi_tupla = (10, 20, 30, 30, 40, 50, 30)
valor_dado = 30

indices_encontrados = encontrar_indices(mi_tupla, valor_dado)

if indices_encontrados:
    print(f"El valor {valor_dado} se encuentra en los índices: {indices_encontrados}")
else:
    print(f"El valor {valor_dado} no se encuentra en la tupla.")
```

validar sin en una lista los elementos son numeros

```
# Definir una lista
mi_lista = [1, 2, 3, 'a', 'b', 4.5]

# Validar si los elementos de la lista son números
son_numeros = all(isinstance(elemento, (int, float)) for elemento in mi_lista)

if son_numeros:
    print("Todos los elementos de la lista son números.")
else:
    print("Al menos un elemento de la lista no es un número.")
```

___________

```
'''
*
**
***
****
*****
'''

for i in range(1, 6):
    # Imprimir '*' repetido 'i' veces en cada iteración
    print('*' * i)

```
__________________
```
import string

def ispangram(str1, alphabet=string.ascii_lowercase): 
    # Create a set of the alphabet
    alphaset = set(alphabet)  
    
    # Remove spaces from str1
    str1 = str1.replace(" ",'')
    
    # Lowercase all strings in the passed in string
    # Recall we assume no punctuation 
    str1 = str1.lower()
    
    # Grab all unique letters in the string as a set
    str1 = set(str1)
    
    # Now check that the alpahbet set is same as string set
    return str1 == alphaset

print(ispangram("The quick brown fox jumps over the lazy dog"))
```
