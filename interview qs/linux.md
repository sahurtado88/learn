# Linux

||||
|-|-|-|
|/|Root Directory|Is the starting point of the linux file system hierarchy|
|/bin|Binary Programs|Contains essential binary executables (programs) that are available to all users. Common commands like ls,cp,mv, etc are located here|
|/boot|Bootloaders Files|Contains boot-related files, such as the linux kernel, initial RAM disk (initrd), and boot loader configurations. The boot loader is responsible for loading the operating system during the boot process|
|/dev|Devices Files|Contains device files that represent various hardware devices on the system. These files allow access to devices such as hard drives, USB devices, serial ports,etc|
|/etc|System configuration Files|Contains system-wide configuration files and scripts. Configuration files for various services, network settings, user information,etc, are stored here|
|/home|Home directories|Contains personal home directories for each user on the system. Each user has a subdirectory here with their username, where they can store their personal files and settings|
|/lib|Shared libraries|Contains shared libraries requiered by the system and various programs. These libraries provide common functions and features to multiple applications|
|/mnt|Mount directory|Used as a temporary mount point for mounting external file systems, such as removable media or networks shares|
|/opt|Optional Software|Typically used for installing additional software packages that are not part of the default system installation. Third party applications or programs that are not managed by the system's package manager may be installed here|
|/proc|Process Information|A virtual file system that provides information about running processes and system resources. Each process has a directory named after its process ID (PID), containing information about the proccess|
|/sbin|System binaries|Contains system-related binaries (programs) that are mostly used by system administrator. Commands necessary for systems maintenance or system recovery are located here|
|/tmp|Temporary files|Used for storing temporary files created by the system and users. Files in this directory are typically deleted when the system is rebooted|
|/usr|User Programs Data| Contains user-related programs, libraries, and data files It is one of the largest directories and is further divided into subdirectories such as /usr/bin, usr/lib, usr/include, etc|
|/var|Variable Data|Contains variable files that change during system|


## Linux package manager
On Linux, the package manager will change based on the Linux distribution you choose.

|Distribution(s)|	Package manager|
|-|-|
|Ubuntu, Debian|	apt-get|
|Red Hat, CentOS|	yum|
|OpenSUSE|	zypper|
|Fedora|	dnf|

## Some Commands

- whatis command:breve descripcion de un comando

- du estimate file space usage
- df report file system disk space usage
- more -n \<filename> this option display the text upto the specified n number of lines of the document
- more +n \<filename> displays the text from the specified n number of lines of the document
- head -n \<filename> primeras 10 lineas del docuemnto por defecto
- tail -n \<filename> ultimas lineas del documento por defecto 10 (si no se pone n)
- sed -n 'initial_line, last_linep' \<filename>

 (sed -n '6,12p' xyz.txt) 
 
  imprimir un rango de lineas de un documento
- grep is a filter command

grep[options] "string/pattern" file/files

- lsof list of files used by PID
- telnet 

## STDIN, STDOUT, STERR
A file descriptor is simply an integer number to identify STDIN, STDOUT and STDERR

0: STDIN
1: STDOUT
2: STDERR

## permisions

![](![alt text](image-88.png))

![](![alt text](image-89.png))

```
* R - read    -> 4
* W - Write   -> 2
* X - excute  -> 1

# GREP AWK SED

## GREP
grep = global regular expression print
In the simplest terms, grep (global regular expression print) will search input files for a search
string, and print the lines that match it. B

## AWK
A text pattern scanning and processing language, created by Aho, Weinberger & Kernighan (hence
the name). It can be quite sophisticated so this is NOT a complete guide, but should give you a taste
of what awk can do. It can be very simple to use, and is strongly recommended. There are many
on-line tutorials of varying complexity, and of course, there is always 'man awk'.
AWK basics
An awk program operates on each line of an input file. It can have an optional BEGIN{} section of
commands that are done before processing any content of the file, then the main {} section works
on each line of the file, and finally there is an optional END{} section of actions that happen after
the file reading has finished:

## SED
sed = stream editor
sed performs basic text transformations on an input stream (a file or input from a pipeline) in a
single pass through the stream, so it is very efficient. However, it is sed's ability to filter text in a
pipeline which particularly distinguishes it from other types of editor.
