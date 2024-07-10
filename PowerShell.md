# PowerShell

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

## Aliases

## objects

## Sorting

## Filtering using where Cmdlet