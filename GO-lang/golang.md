# GO

Go is an open source porgramming language developed by google

- focus on simplicity, clarity and scalability
- high performance and focus on concurrency
- batteries included (many features are built- in)
- static typing

# Standard Library

https://pkg.go.dev/std

# Code organization¶
Go programs are organized into packages. A package is a collection of source files in the same directory that are compiled together. Functions, types, variables, and constants defined in one source file are visible to all other source files within the same package.

A repository contains one or more modules. A module is a collection of related Go packages that are released together. A Go repository typically contains only one module, located at the root of the repository. A file named go.mod there declares the module path: the import path prefix for all packages within the module. The module contains the packages in the directory containing its go.mod file as well as subdirectories of that directory, up to the next subdirectory containing another go.mod file (if any).

```
go mod init PATH # convert project into module
```

# Go Syntax
A Go file consists of the following parts:

- Package declaration
- Import packages
- Functions
- Statements and expressions

# Go Comments

A comment is a text that is ignored upon execution.

Comments can be used to explain the code, and to make it more readable.

Comments can also be used to prevent code execution when testing an alternative code.

Go supports single-line or multi-line comments.

## Go Single-line Comments
Single-line comments start with two forward slashes (//).

Any text between // and the end of the line is ignored by the compiler (will not be executed).

## Go Multi-line Comments
Multi-line comments start with /* and ends with */.

Any text between /* and */ will be ignored by the compiler

# Go Variables
Variables are containers for storing data values.

## Go Variable Types
In Go, there are different types of variables, for example:

- int- stores integers (whole numbers), such as 123 or -123
- float32- stores floating point numbers, with decimals, such as 19.99 or -19.99
- string - stores text, such as "Hello World". String values are surrounded by double quotes
- bool- stores values with two states: true or false

But there also are some noteworthy "niche" basic types which you'll typically not need that often but which you should still know about:

- uint => An unsigned integer which means a strictly non-negative integer (e.g., 0, 10, 255 etc)

- int32 => A 32-bit signed integer, which is an integer with a specific range from -2,147,483,648 to 2,147,483,647 (e.g., -1234567890, 1234567890)

- rune => An alias for int32, represents a Unicode code point (i.e., a single character), and is used when dealing with Unicode characters (e.g., 'a', 'ñ', '世')

- uint32 => A 32-bit unsigned integer, an integer that can represent values from 0 to 4,294,967,295

- int64 => A 64-bit signed integer, an integer that can represent a larger range of values, specifically from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807

There also are more types like int8 or uint8 which work in the same way (=> integer with smaller number range)

### Null Values
All Go value types come with a so-called "null value" which is the value stored in a variable if no other value is explicitly set.

For example, the following int variable would have a default value of 0 (because 0 is the null value of int, int32 etc):

var age int // age is 0
Here's a list of the null values for the different types:

int => 0

float64 => 0.0

string => "" (i.e., an empty string)

bool => false

## Declaring (Creating) Variables
In Go, there are two ways to declare a variable:

1. With the var keyword:
Use the var keyword, followed by variable name and type:

Syntax
var variablename type = value
Note: You always have to specify either type or value (or both).

2. With the := sign:
Use the := sign, followed by the variable value:

Syntax
variablename := value
Note: In this case, the type of the variable is inferred from the value (means that the compiler decides the type of the variable, based on the value).

Note: It is not possible to declare a variable using :=, without assigning a value to it.

### Difference Between var and :=
There are some small differences between the var var :=:

#### var	
- Can be used inside and outside of functions	
- Variable declaration and value assignment can be done separately	

##### :=
- Can only be used inside functions
- Variable declaration and value assignment cannot be done separately (must be done in the same line)

### Go Variable Naming Rules
A variable can have a short name (like x and y) or a more descriptive name (age, price, carname, etc.).

Go variable naming rules:

A variable name must start with a letter or an underscore character (_)
A variable name cannot start with a digit
A variable name can only contain alpha-numeric characters and underscores (a-z, A-Z, 0-9, and _ )
Variable names are case-sensitive (age, Age and AGE are three different variables)
There is no limit on the length of the variable name
A variable name cannot contain spaces
The variable name cannot be any Go keywords
Multi-Word Variable Names
Variable names with more than one word can be difficult to read.

There are several techniques you can use to make them more readable:

Camel Case
Each word, except the first, starts with a capital letter:

myVariableName = "John"
Pascal Case
Each word starts with a capital letter:

MyVariableName = "John"
Snake Case
Each word is separated by an underscore character:

my_variable_name = "John"

# Go Constants

If a variable should have a fixed value that cannot be changed, you can use the const keyword.

The const keyword declares the variable as "constant", which means that it is unchangeable and read-only.

Syntax
const CONSTNAME type = value

## Constant Rules

- Constant names follow the same naming rules as variables
- Constant names are usually written in uppercase letters (for easy identification and differentiation from variables)
- Constants can be declared both inside and outside of a function

## Constant Types
There are two types of constants:

### Typed constants
Typed constants are declared with a defined type

```
package main
import ("fmt")

const A int = 1

func main() {
  fmt.Println(A)
}
```
### Untyped constants

Untyped constants are declared without a type:

```
package main
import ("fmt")

const A = 1

func main() {
  fmt.Println(A)
}
```

## Multiple Constants Declaration
Multiple constants can be grouped together into a block for readability:

Example
```
package main
import ("fmt")

const (
  A int = 1
  B = 3.14
  C = "Hi!"
)

func main() {
  fmt.Println(A)
  fmt.Println(B)
  fmt.Println(C)
}
```