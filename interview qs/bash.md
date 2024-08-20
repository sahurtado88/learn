# Bash

What is the alternative command for echo?

The alternative command for echo is tput. This command allows us to control how the output is displayed on the screen. 

Tell us about the ‘$#’ use in shell scripting.

'$#' is used to display the total number of passed arguments to the script. 

Name standard streams in Linux.

The standard streams in Linux are Standard Input, Standard Output, and Standard Error.

Explain Crontab.

Crontab means cron table because the tasks are executed using the job scheduler ‘cron.' It is a list of commands that run on a regular schedule, and the name of the command also manages the list. Crontab is the schedule and also the name of the program used to edit the schedule. 

6. Differentiate between $@ and $*.

$* considers an entire set of positional arguments as a single string whereas, $@ treats each quote argument as a separate argument.  

Tell us how you can compare strings in a shell script.

To compare the text strings, we use the ‘test’ command. This command compares text strings by comparing each character of each string. 

```
#!/bin/bash

# Define two strings
string1="Hello"
string2="World"

# Compare strings using [[ ]]
if [[ "$string1" == "$string2" ]]; then
    echo "Strings are equal"
else
    echo "Strings are not equal"
fi

```

How will you debug problems encountered in the shell program?

Some standard methods of debugging the problems in the script are:

use of set-x to enable debugging
Insert debug statements in a shell script to display information that helps in the identification of the problem. 

```
#!/bin/bash

# Enable debug mode
set -x

# Define variables
a=10
b=20

# Perform arithmetic operations
sum=$((a + b))
product=$((a * b))

# Print the results
echo "Sum: $sum"
echo "Product: $product"
_________________________

+ a=10
+ b=20
+ sum=30
+ product=200
+ echo 'Sum: 30'
Sum: 30
+ echo 'Product: 200'
Product: 200

```
How can you print a substring in bash?

In Bash, you can print a substring of a string using parameter expansion with the ${parameter:offset:length} syntax.
parameter is the variable containing the string.
offset is the starting position of the substring (0-based index).
length is the length of the substring to print. If length is omitted, the substring extends to the end of the original string.
By adjusting the offset and length parameters, you can print different substrings from the original string.

 Here's how you can do it:

```
#!/bin/bash

# Define a string
my_string="Hello, World!"

# Print a substring starting from a specific offset
echo "${my_string:7}"   # Output: World!

# Print a substring starting from a specific offset with a specified length
echo "${my_string:7:5}" # Output: World

```

7. Please tell us how you will check if a file exists on the filesystem.

Using the following:
```
if [ -f /var/log/messages ]

then

echo "File exists."

fi
```
9. What is the difference between [[ $string == "efg*" ]] and [[ $string == efg* ]] ?
[[ $string == efg* ]] – checks if string begins with efg. 

[[ $string == "efg*" ]] – checks if string is efg. 

10. In what ways, shell script get input values?
a. By reading command: read -p "Destination backup Server: " dest host

b. By parameters: ./script param1 param2

4) What is the equivalent of a file shortcut that we have a window on a Linux system?

Shortcuts are created using “links” on Linux. There are two types of links that can be used namely “soft link” and “hard link”.

5) What is the difference between soft and hard links?

Soft links are link to the file name and can reside on different filesytem as well; however hard links are link to the inode of the file and have to be on the same filesytem as that of the file. Deleting the original file makes the soft link inactive (broken link) but does not affect the hard link (Hard link will still access a copy of the file)

18) What is the difference between $$ and $!?

\$$ gives the process id of the currently executing process whereas $! Shows the process id of the process that recently went into the background.

What are zombie processes?

These are the processes which have died but whose exit status is still not picked by the parent process. These processes even if not functional still have its process id entry in the process table.

21) I want to monitor a continuously updating log file, what command can be used to most efficiently achieve this?

We can use tail –f filename. This will cause only the default last 10 lines to be displayed on std o/p which continuously shows the updating part of the file.

22) I want to connect to a remote server and execute some commands, how can I achieve this?

We can use ssh to do this:

ssh username@serverIP -p sshport

Example

ssh root@122.52.251.171 -p 22

Once above command is executed, you will be asked to enter the password

23) I have 2 files and I want to print the records which are common to both.

We can use “comm” command as follows:

comm -12 file1 file2 … 12 will suppress the content which are

unique to 1st and 2nd file respectively.

24) Write a script to print the first 10 elements of Fibonacci series.

```
#!/bin/bash

# Definir la cantidad de términos en la serie Fibonacci
n=10

# Inicializar los primeros dos términos de la serie
a=0
b=1

# Mostrar los primeros dos términos de la serie
echo "Serie Fibonacci de $n términos:"
echo -n "$a, $b"

# Calcular y mostrar los siguientes términos de la serie
for ((i=2; i<n; i++))
do
    # Calcular el siguiente término
    c=$((a + b))
    
    # Mostrar el término calculado
    echo -n ", $c"
    
    # Actualizar los valores de a y b para el próximo cálculo
    a=$b
    b=$c
done

echo ""  # Salto de línea al final

```
How will you connect to a database server from Linux?
We can use isql utility that comes with open client driver as follows:

isql –S serverName –U username –P password

26) What are the 3 standard streams in Linux?

0 – Standard Input1 – Standard Output2 – Standard Error

27) I want to read all input to the command from file1 direct all output to file2 and error to file 3, how can I achieve this?

command <file1 1>file2 2>file3

30) Given a file find the count of lines containing the word “ABC”.

grep –c “ABC” file1

31) What is the difference between grep and egrep?

egrep is Extended grep that supports added grep features like “+” (1 or more occurrence of a previous character),”?”(0 or 1 occurrence of a previous character) and “|” (alternate matching)

34) How will you find the total disk space used by a specific user?

du -s /home/user1 ….where user1 is the user for whom the total disk space needs to be found.

32) How to set an array in Linux?

Syntax in ksh:

Set –A arrayname= (element1 element2 ….. element)
In bash
A=(element1 element2 element3 …. elementn)
33) Write down the syntax of “for ” loop

Syntax:
```
for  iterator in (elements)
do
execute commands
done
```

34) How will you find the total disk space used by a specific user?

du -s /home/user1 ….where user1 is the user for whom the total disk space needs to be found.

35) Write the syntax for “if” conditionals in Linux?
Syntax


If  condition is successful
then
execute commands
else
execute commands
fi
36) What is the significance of $?

The command $? gives the exit status of the last command that was executed.

How do we delete all blank lines in a file?
sed  '^ [(backslash)011(backslash)040]*$/d' file1
where (backslash)011 is an octal equivalent of space and

(backslash)040 is an octal equivalent of the tab

How will I insert a line “ABCDEF” at every 100th line of a file?
sed ‘100i\ABCDEF’ file1

39) Write a command sequence to find all the files modified in less than 2 days and print the record count of each.

find . –mtime -2 –exec wc –l {} \;

How can we find the process name from its process id?

We can use "ps –p ProcessId"

42) What are the four fundamental components of every file system on Linux?

Bootblock, super block, inode block and Datablock are found fundamental components of every file system on Linux.

43) What is a boot block?

This block contains a small program called “Master Boot record”(MBR) which loads the kernel during system boot up.

44) What is a super block?

Super block contains all the information about the file system like the size of file system, block size used by its number of free data blocks and list of free inodes and data blocks.

45 What is an inode block?

This block contains the inode for every file of the file system along with all the file attributes except its name.

46) How can I send a mail with a compressed file as an attachment?

zip file1.zip file1|mailx –s “subject” Recipients email id

Email content

EOF

47) How do we create command aliases in a shell?

alias Aliasname=”Command whose alias is to be created”.

49 AWK

awk is a powerful text-processing tool available on Unix and Linux command lines. It's primarily used to search and manipulate text in text files or the output of other commands.
La sintaxis básica de awk es la siguiente:

bash
Copy code
awk 'patrón {acción}' archivo
Donde:

'patrón' es una expresión que define qué líneas procesar.
'{acción}' es el conjunto de comandos que se ejecutarán en las líneas que coincidan con el patrón.
'archivo' es el archivo de texto que awk va a procesar. Si no se especifica ningún archivo, awk procesará la entrada estándar.
Aquí tienes algunos ejemplos de cómo puedes usar awk:

Imprimir una Columna Específica de un Archivo CSV:

bash
Copy code
awk -F ',' '{print $1}' archivo.csv
Esto imprimirá la primera columna del archivo CSV archivo.csv, asumiendo que el delimitador es una coma.

Buscar y Filtrar Líneas que Contienen una Palabra Específica:

bash
Copy code
awk '/patrón/' archivo
Esto imprimirá todas las líneas del archivo que contienen la palabra 'patrón'.

Calcular la Suma de una Columna Numérica:

bash
Copy code
awk '{suma += $1} END {print suma}' archivo
Esto calculará la suma de la primera columna numérica del archivo y la imprimirá al final del procesamiento.

Contar el Número de Líneas en un Archivo:

bash
Copy code
awk 'END {print NR}' archivo
Esto imprimirá el número total de líneas en el archivo.

Estos son solo algunos ejemplos básicos de cómo puedes utilizar awk. Es una herramienta muy versátil y potente que puedes utilizar para realizar una amplia variedad de tareas de procesamiento de texto en la línea de comandos.


50 SED

sed stands for "stream editor" and it's a powerful command-line tool used for performing text transformations on an input stream or files. It's particularly useful for tasks such as search and replace, text substitution, and line-by-line processing.

Here are some key features and common uses of sed:

Search and Replace:

You can use sed to search for a pattern in a text file or input stream and replace it with another pattern. For example:

bash
Copy code
sed 's/pattern/replacement/g' file.txt
This command searches for all occurrences of "pattern" in file.txt and replaces them with "replacement".

Delete Lines:

sed can delete lines from a file or input stream based on a pattern. For example:

bash
Copy code
sed '/pattern/d' file.txt
This command deletes all lines from file.txt that contain the pattern "pattern".

Insert, Append, and Change Text:

You can use sed to insert, append, or change text in specific lines of a file. For example:

bash
Copy code
sed '2i\Inserting text on line 2' file.txt
This command inserts the text "Inserting text on line 2" before line 2 in file.txt.

Regular Expressions:

sed supports powerful regular expressions for pattern matching and substitution. This allows you to perform complex text transformations. For example:

bash
Copy code
sed 's/[0-9]\+/#&/g' file.txt
This command replaces all occurrences of numbers with "#number" in file.txt.

In-Place Editing:

sed can edit files in-place, meaning it modifies the original file rather than writing to standard output. For example:

bash
Copy code
sed -i 's/pattern/replacement/g' file.txt
This command replaces all occurrences of "pattern" with "replacement" in file.txt and saves the changes to the file.

These are just a few examples of what you can do with sed. It's a versatile and powerful tool for text manipulation on the command line.

# Difference between single and double quotes in Bash

Single quotes won't interpolate anything, but double quotes will. For example: variables, backticks, certain \ escapes, etc.

3.1.2.2 Single Quotes

Enclosing characters in single quotes (') preserves the literal value of each character within the quotes. A single quote may not occur between single quotes, even when preceded by a backslash.

3.1.2.3 Double Quotes

Enclosing characters in double quotes (") preserves the literal value of all characters within the quotes, with the exception of $, `, \, and, when history expansion is enabled, !. The characters $ and ` retain their special meaning within double quotes (see Shell Expansions). 

If we set

a=apple      # a simple variable
arr=(apple)  # an indexed array with a single element

![alt text](image-34.png)

```
TM="SERGIO"
echo $TM
SERGIO
echo $'TM'
TM
echo $"TM"
TM
echo $`TM`
TM: command not found
echo $(TM)
TM:  command not found
echo $("TM")
TM: command not found

echo$ echo $('TM')
TM: command not foundn

echo $(`TM`)
TM: command not found

echo$(`ls`)
bash: adhoc.sh: command not found

echo $(ls) or echo $("ls") or echo $('ls') show the list directory
```

