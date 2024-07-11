# PowerShell 

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases?view=powershell-7.4

PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting language, and a configuration management framework. PowerShell runs on Windows, Linux, and macOS.

 get member show methods and properties

## Basic Data type

Int, String, Boolean

## Comparison Operators

### Equality

-eq, -ieq, -ceq - equals
-ne, -ine, -cne - not equals
-gt, -igt, -cgt - greater than
-ge, -ige, -cge - greater than or equal
-lt, -ilt, -clt - less than
-le, -ile, -cle - less than or equal

### Matching

-like, -ilike, -clike - string matches wildcard pattern
-notlike, -inotlike, -cnotlike - string doesn't match wildcard pattern
-match, -imatch, -cmatch - string matches regex pattern
-notmatch, -inotmatch, -cnotmatch - string doesn't match regex pattern

### Replacement

-replace, -ireplace, -creplace - replaces strings matching a regex pattern

### Containment

-contains, -icontains, -ccontains - collection contains a value
-notcontains, -inotcontains, -cnotcontains - collection doesn't contain a value
-in - value is in a collection
-notin - value isn't in a collection

### Type

-is - both objects are the same type
-isnot - the objects aren't the same type

There are three variants of most comparison operators. The basic variant is case-insensitive when making comparisons. In order to change this behaviour, precede the operator name with a “c” or an “i” as shown in the following example.

-eq = case-insensitive comparison
-ceq = case-sensitive comparison
-ieq = case-insensitive comparison

#### wildcard
Wildcard characters represent one or many characters. You can use them to create word patterns in commands. Wildcard expressions are used with the -like operator or with any parameter that accepts wildcards

PowerShell supports the following wildcard characters:
```
* - Match zero or more characters
    a* matches aA, ag, and Apple
    a* doesn't match banana
? - For strings, match one character in that position
    ?n matches an, in, and on
    ?n doesn't match ran
? - For files and directories, match zero or one character in that position
    ?.txt matches a.txt and b.txt
    ?.txt doesn't match ab.txt
[ ] - Match a range of characters
    [a-l]ook matches book, cook, and look
    [a-l]ook doesn't match took
[ ] - Match specific characters
    [bc]ook matches book and cook
    [bc]ook doesn't match hook
`* - Match any character as a literal (not a wildcard character)
    12`*4 matches 12*4
    12`*4 doesn't match 1234

```
## Cmdlet Basics

A cmdlet is a lightweight command that is used in the PowerShell environment. The PowerShell runtime invokes these cmdlets within the context of automation scripts that are provided at the command line. The PowerShell runtime also invokes them programmatically through PowerShell APIs.

```
get-process  # process that are running
get-service
write-host "hello world"

```

## Aliases

An alias is an alternate name or nickname for a cmdlet or for a command element, such as a function, script, file, or executable file. You can use the alias instead of the command name in any PowerShell commands.

To create an alias, use the New-Alias cmdlet. For example, the following command creates the gas alias for the Get-AuthenticodeSignature cmdlet:

```
New-Alias -Name gas -Value Get-AuthenticodeSignature

set-alias blah Get-Process
```
## Getting help

to know about some ocmmand you cna use the word help to know about this command

```
help ls

help ls -online # open iofo in your internet explorer
```

## objects

Every action you take in PowerShell occurs within the context of objects. As data moves from one command to the next, it moves as one or more identifiable objects. An object, then, is a collection of data that represents an item. An object is made up of three types of data: the objects type, its methods, and its properties.

```
dir | get-member
```

## Sorting

```
Get-Process | Sort-Object -Property WS | Select-Object -Last 5 # Sort processes by memory usage

Get-History | Sort-Object -Property Id -Descending  # Sort HistoryInfo objects by Id

Get-ChildItem -Path C:\Test -File | Sort-Object -Property Length # Sort the current directory by file length
```


## Filtering using where Cmdlet

with Where-object Selects objects from a collection based on their property values.

```

Get-Service | Where-Object Status -EQ "Stopped" # Get stopped services

Get-Process | Where-Object ProcessName -Match "^p.*" # Get processes based on process name

Get-Process | Where-Object WorkingSet -GT 250MB # Get processes based on working set

dir | where name -eq Contacts

```

## Filtering Using loops

```
Get-Service | Where-Object { $_.Status -eq "Stopped" -and ($_.Name -like "D*") }
```
$_ is a variable created by the system usually inside block expressions that are referenced by cmdlets that are used with pipe such as Where-Object and ForEach-Object. $_ is the current object

## Foreach Loops

The foreach statement is a language construct for iterating over a set of values in a collection.

The simplest and most typical type of collection to traverse is an array. Within a foreach loop, it's common to run one or more commands against each item in an array.

```
$letterArray = 'a','b','c','d'
foreach ($letter in $letterArray)
{
  Write-Host $letter
}
```
```
1..10 | foreach {$_*4} #multiply for 4 all the elements

1..10 | foreach {"+"*$_} # write plus sign  1 to ten

1..10 | foreach{if($_%2){"$_ is odd"}}
```

## Arrays

An array is a data structure that's designed to store a collection of items. The items can be the same type or different types.

Beginning in Windows PowerShell 3.0, a collection of zero or one object has some properties of arrays.

For example, to create an array named $A that contains the seven numeric (integer) values of 22, 5, 10, 8, 12, 9, and 80, type:

```
$A = 22,5,10,8,12,9,80
```

For example, to create a single item array named $B containing the single value of 7, type:

```
$B = ,7
```

**The array sub-expression operator**
The array sub-expression operator creates an array from the statements inside it. Whatever the statement inside the operator produces, the operator places it in an array. Even if there is zero or one object.

```
@( ... )
```

## Hash Tables

A hashtable, also known as a dictionary or associative array, is a compact data structure that stores one or more key-value pairs. For example, a hash table might contain a series of IP addresses and computer names, where the IP addresses are the keys and the computer names are the values, or vice versa.

The syntax of a hashtable is as follows:

```
@{ <name> = <value>; [<name> = <value> ] ...}
```
The syntax of an ordered dictionary is as follows:

```
[ordered]@{ <name> = <value>; [<name> = <value> ] ...}
```

To create a hashtable, follow these guidelines:

Begin the hashtable with an at sign (@).
Enclose the hashtable in braces ({}).
Enter one or more key-value pairs for the content of the hashtable.
Use an equal sign (=) to separate each key from its value.
Use a semicolon (;) or a line break to separate the key-value pairs.
Keys that contain spaces must be enclosed in quotation marks. Values must be valid PowerShell expressions. Strings must appear in quotation marks, even if they don't include spaces.
To manage the hashtable, save it in a variable.
When assigning an ordered hashtable to a variable, place the [ordered] type before the @ symbol. If you place it before the variable name, the command fails.

To create an empty hashtable in the value of $hash, type:

```
$hash = @{}
```

hashtables have Keys and Values properties. Use dot notation to display all the keys or all the values

```
$hash.keys
$hash.values

```


### Formatting output


