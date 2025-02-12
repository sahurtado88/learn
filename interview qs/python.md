


Stack LIFO

QUEUE FIFO

# __INIT__
En Python, __init__ es un método especial que se utiliza para inicializar objetos de una clase. Es conocido como el método de inicialización o constructor de la clase. Cuando se crea una nueva instancia de una clase, el método __init__ se llama automáticamente, permitiendo la inicialización de los atributos de la instancia.

# Inmutables

tuple and frozenset

# Mutables

list, dict and set

# Time complexity  accesing python list

In Python, accessing an element in a list by index has a time complexity of O(1). This means that the time it takes to access an element from a list is constant and does not depend on the size of the list. Whether the list has 10 elements or 10 million elements, accessing an element by index will typically take the same amount of time.

# SUPER CLASS

In Python, the super() function is used within a subclass to call methods and constructors from its parent class (also known as the superclass or base class). It allows the subclass to access and invoke methods defined in the parent class.

# Instance variable and Class Variable


In Python, instance variables and class variables are both types of variables used in object-oriented programming, but they serve different purposes and have different scopes.

**Instance Variables:**

- Instance variables are variables that are specific to each instance (object) of a class.
They are defined within the methods of a class using the self keyword.
- Each object of the class maintains its own copy of instance variables.
- Instance variables hold data that are unique to each instance/object.
They are typically initialized in the constructor (__init__ method) of the class.
- Instance variables are accessed using dot notation (self.variable_name) within methods of the class or through instances of the class.

**Class Variables:**

- Class variables are variables that are shared across all instances of a class.
- They are defined within the class but outside of any method, usually at the top of the class definition.
- Class variables are accessed using the class name itself or through instances of the class.
- Class variables hold data that is shared among all instances of the class.
- They are typically used to store data that is common to all instances of the class.
- Modifying a class variable affects all instances of the class.

 class_variable is a class variable shared by all instances of MyClass, while instance_variable is an instance variable unique to each instance of MyClass.

 # Metaclass

 En Python, un metaclass (metaclase) es una clase cuyas instancias son clases. Es decir, mientras que una clase es un molde para crear objetos, una metaclase es un molde para crear clases. Puedes pensar en una metaclase como una "clase de clases".

 Una de las aplicaciones más comunes de las metaclases es la personalización del comportamiento de la creación de clases. Por ejemplo, puedes usar una metaclase para modificar la creación de clases de tal manera que todas las clases creadas con esa metaclase tengan ciertas características o métodos adicionales.

 # CLousure

 
Un closure en Python es una función que hace referencia a variables de un ámbito exterior en el cual no fue definida. La función puede "recordar" el ámbito en el que fue creada y acceder a las variables de ese ámbito, incluso después de que dicho ámbito ya no esté activo.

Los closures son útiles para crear funciones que encapsulan datos y comportamientos relacionados. Se utilizan frecuentemente en programación funcional y en el diseño de APIs donde se desean funciones que mantengan un estado interno.

# GIL


GIL (Global Interpreter Lock) es un mecanismo de bloqueo en el intérprete de Python que garantiza que solo un subproceso (thread) ejecute código Python a la vez en un proceso Python. Esto significa que, aunque Python tiene soporte para la concurrencia mediante subprocesos, el GIL limita efectivamente la ejecución simultánea de múltiples subprocesos que ejecutan código Python dentro del mismo proceso.

# ASYNCIO


asyncio es un módulo de Python que proporciona una infraestructura para escribir código concurrente utilizando la sintaxis async/await. Permite la ejecución concurrente de tareas asíncronas, lo que es útil para realizar operaciones de entrada/salida (I/O) de manera eficiente, como solicitudes de red, operaciones de archivo o interacciones con bases de datos, sin bloquear el hilo principal de ejecución.

# ASYNC AND AWAIT


async y await son dos palabras clave introducidas en Python 3.5 para facilitar la escritura de código asíncrono y aprovechar el modelo de programación asíncrona de Python.

async: Se utiliza para definir funciones asincrónicas, es decir, funciones que pueden pausarse y reanudarse en puntos específicos sin bloquear el hilo de ejecución principal. Las funciones definidas con async def son corutinas, que pueden contener llamadas asíncronas (operaciones que pueden tomar tiempo) y pueden ser esperadas utilizando await.

await: Se utiliza dentro de corutinas para esperar la finalización de una operación asíncrona. Cuando se encuentra una expresión await, la ejecución de la corutina se suspende hasta que la operación asincrónica haya completado su ejecución. Mientras la operación espera, el control se devuelve al bucle de eventos asyncio para que otras tareas puedan ejecutarse.

# PYTHON DESCRIPTOR

Un descriptor en Python es un protocolo que define cómo los atributos de una clase interactúan con la asignación y recuperación de valores. Los descriptores son objetos que pueden personalizar la forma en que se acceden, establecen y eliminan los valores de los atributos en Python. Son útiles para implementar comportamientos específicos en los atributos de una clase, como la validación de datos, la creación de propiedades computadas o el control de acceso a los atributos.

Un descriptor debe implementar al menos uno de los siguientes métodos especiales:

__get__(self, instance, owner): Se llama cuando se accede al atributo. instance es la instancia de la clase que contiene el atributo, y owner es la clase que contiene el atributo.

__set__(self, instance, value): Se llama cuando se establece el valor del atributo. instance es la instancia de la clase que contiene el atributo, y value es el valor que se está asignando al atributo.

__delete__(self, instance): Se llama cuando se elimina el atributo. instance es la instancia de la clase que contiene el atributo.

Los descriptores son una característica avanzada de Python que se utilizan en bibliotecas y marcos de trabajo para crear una sintaxis más limpia y expresiva al interactuar con atributos de clase.

# CONTEXTLIB


contextlib es un módulo de la biblioteca estándar de Python que proporciona utilidades para trabajar con contextos de ejecución (context managers) de manera más concisa y expresiva. Los contextos de ejecución se utilizan para definir acciones que deben realizarse antes y después de una sección de código.

El módulo contextlib incluye varias funciones y clases útiles para trabajar con context managers, pero una de las más comunes es contextmanager. Esta función decoradora permite definir un generador que actúa como un context manager de manera más concisa que crear una clase de contexto completa.

# Generator Expression

Una expresión de generador (generator expression) en Python es una construcción sintáctica que permite crear generadores de manera concisa y eficiente. Al igual que las listas por comprensión, las expresiones de generador proporcionan una forma de crear secuencias de elementos, pero en lugar de crear una lista completa en memoria, generan los elementos uno a la vez a medida que se solicitan.

La sintaxis básica de una expresión de generador es similar a la de una lista por comprensión, pero en lugar de usar corchetes ([]), se utilizan paréntesis () o, a veces, se pueden omitir para crear un generador.

Las expresiones de generador son útiles cuando necesitas iterar sobre una secuencia de elementos y no necesitas almacenar todos los elementos en memoria a la vez, lo que puede ser útil cuando trabajas con grandes conjuntos de datos o cuando la memoria es limitada.

# Hinting


El "hinting" en Python, también conocido como "type hinting", se refiere a la capacidad de proporcionar información sobre los tipos de datos esperados (anotaciones de tipo) en la definición de funciones, variables y clases. Aunque Python es un lenguaje de programación dinámico y no requiere declaraciones de tipo, el hinting de tipo proporciona una forma opcional de especificar los tipos de datos que se esperan en una función o método.

El "hinting" de tipo se introdujo en Python 3.5 y se puede usar con cualquier editor de texto o IDE que admita la sintaxis de Python, aunque su interpretación es completamente opcional y no afecta al tiempo de ejecución del código.

El hinting de tipo proporciona los siguientes beneficios:

Documentación mejorada: Las anotaciones de tipo pueden servir como documentación para el código, ayudando a comprender la intención del programador sobre los tipos de datos esperados y devueltos por una función.

Ayuda para el desarrollo: Las herramientas de desarrollo pueden utilizar las anotaciones de tipo para proporcionar sugerencias y advertencias sobre posibles errores en el código, como la llamada incorrecta a una función con tipos de datos incompatibles.

Mejora la legibilidad y el mantenimiento del código: Al especificar explícitamente los tipos de datos esperados, el código puede ser más legible y menos propenso a errores, lo que facilita su mantenimiento y colaboración en proyectos más grandes.

Es importante tener en cuenta que las anotaciones de tipo en Python son opcionales y no afectan al comportamiento o rendimiento del código en tiempo de ejecución.

# Python virtual environment

1. instalar virtualenv
```
pip install virtualenv
```

2. Crear una carpeta que albergara el entorno virtual
3. En la carpeta creada en el paso anterior ejecutar el comando
```
virtualenv p1
```
donde p1 es el nombre del entorno a crear
4. ''''Activar el virtual environment
en la carpeta creada ingresar a \p1\Scripts\activate

desactivar entorno virtual se usa \p1\Scripts\deactivate ````

# FUNCION ANONIMA LAMBDA
En Python, las funciones lambda son también conocidas como funciones anónimas porque se definen sin un nombre.

A continuación, te detallo las características principales de una función anónima:

Son funciones que pueden definir cualquier número de parámetros pero una única expresión. Esta expresión es evaluada y devuelta.
Se pueden usar en cualquier lugar en el que una función sea requerida.
Estas funciones están restringidas al uso de una sola expresión.
Se suelen usar en combinación con otras funciones, generalmente como argumentos de otra función.

# YIELD

Los generadores se definen utilizando funciones normales de Python, pero en lugar de usar la declaración return para devolver un valor, utilizan la declaración yield. Cuando una función con yield es llamada, no se ejecuta completamente de una vez; en cambio, la función se detiene en cada yield, devolviendo el valor especificado y suspendiendo su estado hasta que se solicite el próximo valor.

#   1. What is Python? List some popular applications of Python in the world of technology.
Python is a widely-used general-purpose, high-level programming language. It was created by Guido van Rossum in 1991 and further developed by the Python Software Foundation. It was designed with an emphasis on code readability, and its syntax allows programmers to express their concepts in fewer lines of code.
It is used for:

System Scripting
Web Development
Game Development
Software Development
Complex Mathematics

# 2. What are the benefits of using Python language as a tool in the present scenario?
The following are the benefits of using Python language:

Object-Oriented Language
High-Level Language
Dynamically Typed language
Extensive support for Machine Learning Libraries
Presence of third-party modules
Open source and community development
Portable and Interactive
Portable across Operating systems

# 3. Is Python a compiled language or an interpreted language?
Actually, Python is a partially compiled language and partially interpreted language. The compilation part is done first when we execute our code and this will generate byte code internally this byte code gets converted by the Python virtual machine(p.v.m) according to the underlying platform(machine+operating system).

# 4. What does the ‘#’ symbol do in Python?
‘#’ is used to comment on everything that comes after on the line.

# 5. What is the difference between a Mutable datatype and an Immutable data type?
Mutable data types can be edited i.e., they can change at runtime. Eg – List, Dictionary, etc.
Immutable data types can not be edited i.e., they can not change at runtime. Eg – String, Tuple, etc.

# 6. How are arguments passed by value or by reference in Python?
In Python, arguments are passed by object reference (also called “pass by assignment”). This means that functions receive references to the same objects:

Mutable objects (like lists or dictionaries) can be modified within the function.
Immutable objects (like integers or strings) cannot be changed and reassigning them inside the function doesn’t affect the original object.

# 7. What is the difference between a Set and Dictionary?
The set is unordered collection of unique items that is iterable and mutable. A dictionary in Python is an ordered collection of data values, used to store data values like a map.

# 8. What is List Comprehension? Give an Example.
List comprehension is a syntax construction to ease the creation of a list based on existing iterable.

For Example:

```
my_list = [i for i in range(1, 10)]
```

# 9. What is a lambda function?
A lambda function is an anonymous function. This function can have any number of parameters but, can have just one statement. For Example:

a = lambda x, y : x*y
print(a(7, 19))

# 10. What is a pass in Python?
Pass means performing no operation or in other words, it is a placeholder in the compound statement, where there should be a blank left and nothing has to be written there.

# 11. What is the difference between / and // in Python?
/ represents precise division (result is a floating point number) whereas // represents floor division (result is an integer). For Example:

5//2 = 2
5/2 = 2.5

# 12. How is Exceptional handling done in Python?

There are 3 main keywords i.e. try, except, and finally which are used to catch exceptions and handle the recovering mechanism accordingly. Try is the block of a code that is monitored for errors. Except block gets executed when an error occurs.

The beauty of the final block is to execute the code after trying for an error. This block gets executed irrespective of whether an error occurred or not. Finally, block is used to do the required cleanup activities of objects/variables.

# 13. What is swapcase function in Python?

It is a string’s function that converts all uppercase characters into lowercase and vice versa. It is used to alter the existing case of the string. This method creates a copy of the string which contains all the characters in the swap case. For Example:
```
string = "GeeksforGeeks"
string.swapcase() ---> "gEEKSFORgEEKS"
```
# 14. Difference between for loop and while loop in Python

The “for” Loop is generally used to iterate through the elements of various collection types such as List, Tuple, Set, and Dictionary. Developers use a “for” loop where they have both the conditions start and the end. Whereas, the “while” loop is the actual looping feature that is used in any other programming language. Programmers use a Python while loop where they just have the end conditions.

# 15. Can we Pass a function as an argument in Python?

Yes, Several arguments can be passed to a function, including objects, variables (of the same or distinct data types), and functions. Functions can be passed as parameters to other functions because they are objects. Higher-order functions are functions that can take other functions as arguments.

To read more, refer to the article: Passing function as an argument in Python

# 16. What are *args and **kwargs?

To pass a variable number of arguments to a function in Python, use the special syntax *args and **kwargs in the function specification. Both are to send a variable-length argument list. The syntax *args is used to pass a non-keyworded, variable-length argument list.

# 17. Is Indentation Required in Python?

Yes, indentation is required in Python. A Python interpreter can be informed that a group of statements belongs to a specific block of code by using Python indentation. Indentations make the code easy to read for developers in all programming languages but in Python, it is very important to indent the code in a specific order.

# 18. What is Scope in Python?
The location where we can find a variable and also access it if required is called the scope of a variable.

- Python Local variable: Local variables are those that are initialized within a function and are unique to that function. It cannot be accessed outside of the function.
- Python Global variables: Global variables are the ones that are defined and declared outside any function and are not specified to any function.
- Module-level scope: It refers to the global objects of the current module accessible in the program.
- Outermost scope: It refers to any built-in names that the program can call. The name referenced is located last among the objects in this scope.

# 19. What is docstring in Python?

Python documentation strings (or docstrings) provide a convenient way of associating documentation with Python modules, functions, classes, and methods.

Declaring Docstrings: The docstrings are declared using ”’triple single quotes”’ or “””triple double quotes””” just below the class, method, or function declaration. All functions should have a docstring.
Accessing Docstrings: The docstrings can be accessed using the __doc__ method of the object or using the help function.

# 20. What is a dynamically typed language?

Typed languages are the languages in which we define the type of data type and it will be known by the machine at the compile-time or at runtime. Typed languages can be classified into two categories:

- Statically typed languages: In this type of language, the data type of a variable is known at the compile time which means the programmer has to specify the data type of a variable at the time of its declaration. 
- Dynamically typed languages: These are the languages that do not require any pre-defined data type for any variable as it is interpreted at runtime by the machine itself. In these languages, interpreters assign the data type to a variable at runtime depending on its value.

# 21. What is a break, continue, and pass in Python? 

- The break statement is used to terminate the loop or statement in which it is present. After that, the control will pass to the statements that are present after the break statement, if available.

- Continue is also a loop control statement just like the break statement. continue statement is opposite to that of the break statement, instead of terminating the loop, it forces to execute the next iteration of the loop.

- Pass means performing no operation or in other words, it is a placeholder in the compound statement, where there should be a blank left and nothing has to be written there.

# 22. What are Built-in data types in Python?

The following are the standard or built-in data types in Python:

- Numeric: The numeric data type in Python represents the data that has a numeric value. A numeric value can be an integer, a floating number, a Boolean, or even a complex number.
- Sequence Type: The sequence Data Type in Python is the ordered collection of similar or different data types. There are several sequence types in Python:
Python String
Python List
Python Tuple
Python range
- Mapping Types: In Python, hashable data can be mapped to random objects using a mapping object. There is currently only one common mapping type, the dictionary, and mapping objects are mutable.
- Python Dictionary
Set Types: In Python, a Set is an unordered collection of data types that is iterable, mutable, and has no duplicate elements. The order of elements in a set is undefined though it may consist of various elements.

# 23. How do you floor a number in Python?

The Python math module includes a method that can be used to calculate the floor of a number. 

floor() method in Python returns the floor of x i.e., the largest integer not greater than x. 

Also, The method ceil(x) in Python returns a ceiling value of x i.e., the smallest integer greater than or equal to x.

# 24. What is the difference between xrange and range functions?

range() and xrange() are two functions that could be used to iterate a certain number of times in for loops in Python. 

In Python 3, there is no xrange, but the range function behaves like xrange.
In Python 2
range() – This returns a range object, which is an immutable sequence type that generates the numbers on demand. 
xrange() – This function returns the generator object that can be used to display numbers only by looping. The only particular range is displayed on demand and hence called lazy evaluation.

# 25. What is Dictionary Comprehension? Give an Example

Dictionary Comprehension is a syntax construction to ease the creation of a dictionary based on the existing iterable.

For Example: my_dict = {i:i+7 for i in range(1, 10)}

# 26. Is Tuple Comprehension? If yes, how, and if not why?

(i for i in (1, 2, 3))
Tuple comprehension is not possible in Python because it will end up in a generator, not a tuple comprehension.

# 27. Differentiate between List and Tuple?

Let’s analyze the differences between List and Tuple:

## List

- Lists are Mutable datatype.
- Lists consume more memory
- The list is better for performing operations, such as insertion and deletion.
- The implication of iterations is Time-consuming

## Tuple

- Tuples are Immutable datatype.
- Tuple consumes less memory as compared to the list
- A Tuple data type is appropriate for accessing the elements
- The implication of iterations is comparatively Faster

# 28. What is the difference between a shallow copy and a deep copy?

Shallow copy is used when a new instance type gets created and it keeps values that are copied whereas deep copy stores values that are already copied.

A shallow copy has faster program execution whereas a deep copy makes it slow.

# 29. Which sorting technique is used by sort() and sorted() functions of python?

Python uses the Tim Sort algorithm for sorting. It’s a stable sorting whose worst case is O(N log N). It’s a hybrid sorting algorithm, derived from merge sort and insertion sort, designed to perform well on many kinds of real-world data.

sort() will sort the list in-place, mutating its indexes and returning None , whereas sorted() will return a new sorted list leaving the original list unchanged.

# 30. What are Decorators?
Decorators are a very powerful and useful tool in Python as they are the specific change that we make in Python syntax to alter functions easily.

# 31. How do you debug a Python program?
By using this command we can debug a Python program:

 python -m pdb python-script.py

# 32. What are Iterators in Python?

In Python, iterators are used to iterate a group of elements, containers like a list. Iterators are collections of items, and they can be a list, tuples, or a dictionary. Python iterator implements __itr__ and the next() method to iterate the stored elements. We generally use loops to iterate over the collections (list, tuple) in Python.

# 33. What are Generators in Python?

In Python, the generator is a way that specifies how to implement iterators. It is a normal function except that it yields expression in the function. It does not implement __itr__ and __next__ method and reduces other overheads as well.

If a function contains at least a yield statement, it becomes a generator. The yield keyword pauses the current execution by saving its states and then resumes from the same when required.

# 34. Does Python supports multiple Inheritance?

Python does support multiple inheritances, unlike Java. Multiple inheritances mean that a class can be derived from more than one parent class.

# 35. What is Polymorphism in Python?

Polymorphism means the ability to take multiple forms. Polymorphism allows different classes to be treated as if they are instances of the same class through a common interface. This means that a method in a parent class can be overridden by a method with the same name in a child class, but the child class can provide its own specific implementation. This allows the same method to operate differently depending on the object that invokes it. Polymorphism is about overriding, not overloading; it enables methods to operate on objects of different classes, which can have their own attributes and methods, providing flexibility and reusability in the code.

# 36. Define encapsulation in Python?

Encapsulation means binding the code and the data together. A Python class is an example of encapsulation.

# 37. How do you do data abstraction in Python?

Data Abstraction is providing only the required details and hides the implementation from the world. It can be achieved in Python by using interfaces and abstract classes.

# 38. How is memory management done in Python?

Python uses its private heap space to manage the memory. Basically, all the objects and data structures are stored in the private heap space. Even the programmer can not access this private space as the interpreter takes care of this space. Python also has an inbuilt garbage collector, which recycles all the unused memory and frees the memory and makes it available to the heap space.

# 39. How to delete a file using Python?
We can delete a file using Python by following approaches:

os.remove()
os.unlink()
# 40. What is slicing in Python?
Python Slicing is a string operation for extracting a part of the string, or some part of a list. With this operator, one can specify where to start the slicing, where to end, and specify the step. List slicing returns a new list from the existing list.

Syntax: Lst[ Initial : End : IndexJump ]

# 41. What is a namespace in Python?
A namespace is a naming system used to make sure that names are unique to avoid naming conflicts.


# 42. What is PIP?

PIP is an acronym for Python Installer Package which provides a seamless interface to install various Python modules. It is a command-line tool that can search for packages over the internet and install them without any user interaction.

# 43. What is a zip function?

Python zip() function returns a zip object, which maps a similar index of multiple containers. It takes an iterable, converts it into an iterator and aggregates the elements based on iterables passed. It returns an iterator of tuples.

# 44. What are Pickling and Unpickling?

The Pickle module accepts any Python object and converts it into a string representation and dumps it into a file by using the dump function, this process is called pickling. While the process of retrieving original Python objects from the stored string representation is called unpickling.

# 45. What is monkey patching in Python?
In Python, the term monkey patch only refers to dynamic modifications of a class or module at run-time.

# g.py
class GeeksClass:
    def function(self):
        print "function()"

import m
def monkey_function(self):
    print "monkey_function()"
 
m.GeeksClass.function = monkey_function
obj = m.GeeksClass()
obj.function()

# 46. What is __init__() in Python?

The __init__() method in Python is equivalent to constructors in OOP terminology. It is a reserved method in Python classes and is called automatically whenever a new object is instantiated. This method is used to initialize the object’s attributes with values. While __init__() initializes the object, it does not allocate memory. Memory allocation for a new object is handled by the __new__() method, which is called before __init__().

# 47. Write a code to display the current time?
import time

currenttime= time.localtime(time.time())
print (“Current time is”, currenttime)

# 48. What are Access Specifiers in Python?

Python uses the ‘_’ symbol to determine the access control for a specific data member or a member function of a class. A Class in Python has three types of Python access modifiers:

- Public Access Modifier: The members of a class that are declared public are easily accessible from any part of the program. All data members and member functions of a class are public by default. 
- Protected Access Modifier: The members of a class that are declared protected are only accessible to a class derived from it. All data members of a class are declared protected by adding a single underscore ‘_’ symbol before the data members of that class. 
- Private Access Modifier: The members of a class that are declared private are accessible within the class only, the private access modifier is the most secure access modifier. Data members of a class are declared private by adding a double underscore ‘__’ symbol before the data member of that class. 
# 49. What are unit tests in Python?
Unit Testing is the first level of software testing where the smallest testable parts of the software are tested. This is used to validate that each unit of the software performs as designed. The unit test framework is Python’s xUnit style framework. The White Box Testing method is used for Unit testing.

# 50. Python Global Interpreter Lock (GIL)?
Python Global Interpreter Lock (GIL) is a type of process lock that is used by Python whenever it deals with processes. Generally, Python only uses only one thread to execute the set of written statements. The performance of the single-threaded process and the multi-threaded process will be the same in Python and this is because of GIL in Python. We can not achieve multithreading in Python because we have a global interpreter lock that restricts the threads and works as a single thread.

# 51. What are Function Annotations in Python?
Function Annotation is a feature that allows you to add metadata to function parameters and return values. This way you can specify the input type of the function parameters and the return type of the value the function returns.

Function annotations are arbitrary Python expressions that are associated with various parts of functions. These expressions are evaluated at compile time and have no life in Python’s runtime environment. Python does not attach any meaning to these annotations. They take life when interpreted by third-party libraries, for example, mypy.

# 52. What are Exception Groups in Python?
The latest feature of Python 3.11, Exception Groups. The ExceptionGroup can be handled using a new except* syntax. The * symbol indicates that multiple exceptions can be handled by each except* clause.

ExceptionGroup is a collection/group of different kinds of Exception. Without creating Multiple Exceptions we can group together different Exceptions which we can later fetch one by one whenever necessary, the order in which the Exceptions are stored in the Exception Group doesn’t matter while calling them.

```
try:
raise ExceptionGroup('Example ExceptionGroup', (
TypeError('Example TypeError'),
ValueError('Example ValueError'),
KeyError('Example KeyError'),
AttributeError('Example AttributeError')
))
except* TypeError:
...
except* ValueError as e:
...
except* (KeyError, AttributeError) as e:
...
```
# 53. What is Python Switch Statement 
From version 3.10 upward, Python has implemented a switch case feature called “structural pattern matching”. You can implement this feature with the match and case keywords. Note that the underscore symbol is what you use to define a default case for the switch statement in Python.

Note: Before Python 3.10 Python doesn’t support match Statements.


```
match term:
   case pattern-1:
   action-1
   case pattern-2:
   action-2
   case pattern-3:
   action-3
   case _:
   action-default
```

# 54. What is Walrus Operator?
The Walrus Operator allows you to assign a value to a variable within an expression. This can be useful when you need to use a value multiple times in a loop, but don’t want to repeat the calculation.

The Walrus Operator is represented by the `:=` syntax and can be used in a variety of contexts including while loops and if statements.

Note: Python versions before 3.8 doesn’t support Walrus Operator.

```
names = ["Jacob", "Joe", "Jim"]

if (name := input("Enter a name: ")) in names:
    print(f"Hello, {name}!")
else:
    print("Name not found.")
```

```py

def ohmslaw(v, r, c)
    missing_count =[v,r,c].count("")

    if missing_count !=1:
        return "invalid"

    try:
        if v == "":
            return round(r *c, 2)
            elif r=="":
                return round(v /c, 2)
            elif c=="":
                return round(v/r, 2)
    except ZeroDivisionError:
        return "Invalid"

print(ohmslaw(12,220,""))


```