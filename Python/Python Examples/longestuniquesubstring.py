def longest_unique_substring(s):
    n = len(s) # longitud cadena
    max_lenght = 0 # almacenar la longitud de la secuencia mas larga
    start = 0 # marca el inicio de la ventana de la subcadena actual
    visited = {} # un diccionario para registrar el utlimo indice en el que aparecio cada caracter

    for end in range(n):
        if s[end] in visited:
            start = max (start, visited[s[end]]+1)
            print(f"start {start}")

        visited[s[end]] = end
        print(f"visisted {visited}")
        print (f"end {end}")
        max_lenght= max(max_lenght, end-start +1)
        print(f"max lenght: {max_lenght}" )
    return max_lenght

string= "ABCABCDABCDFAB"
result= longest_unique_substring(string)        
print(f"maxima longitud es {result}")

'''
- usamos un bucle para recorrer cada caracter de la cadena 'end' es el indice del caracter actual
- si el caracter actual ('s[end]) ya fue visto y su ultimo indice esta dentro de la ventana actual (desde start) movemos el inicio de la ventana (start) a la derecha del ultimo indice conocido de ese caracter ('visited[s[end]]+1)

- actualizamos el diccionario visited con el indice actula del caracter
-calculamos la longitud de la subcadena actual (end -start+1) y actualizamos (max lenght)
 si encontramso una subcadena mas larga'''