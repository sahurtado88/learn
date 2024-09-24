# LINUX

# Commands - Getting Help
```
##########################
## Getting Help in Linux
##########################
 
# MAN Pages
man command     # => Ex: man ls
 
# The man page is displayed with the less command
# SHORTCUTS:
# h         => getting help
# q         => quit
# enter     => show next line
# space     => show next screen
# /string   => search forward for a string
# ?string   => search backwards for a string
# n / N     => next/previous appearance
 
# checking if a command is shell built-in or executable file
type rm        # => rm is /usr/bin/rm
type cd        # => cd is a shell builtin
 
# getting help for shell built-in commands
help command    # => Ex: help cd
command --help  # => Ex: rm --help
 
# searching for a command, feature or keyword in all man Pages
man -k uname
man -k "copy files"
apropos passwd
```


# Keyboard Shortcuts
```
##########################
TAB  # autocompletes the command or the filename if its unique
TAB TAB (press twice)   # displays all commands or filenames that start with those letters
 
# clearing the terminal
CTRL + L
 
# closing the shell (exit)
CTRL + D
 
# cutting (removing) the current line 
CTRL + U
 
# moving the cursor to the start of the line
CTRL + A
 
# moving the cursor to the end of the line
Ctrl + E
 
# stopping the current command
CTRL + C
 
# sleeping a the running program
CTRL + Z
 
# opening a terminal 
CTRL + ALT + T
```

# Bash History
```
 
# showing the history
history
 
# removing a line (ex: 100) from the history
history -d 100
 
# removing the entire history
history -c
 
# printing the no. of commands saved in the history file (~/.bash_history)
echo $HISTFILESIZE
 
# printing the no. of history commands saved in the memory
echo $HISTSIZE
 
# rerunning the last command from the history
!!
 
# running  a specific command from the history (ex: the 20th command)
!20
 
# running the last nth (10th) command from the history
!-10
 
# running the last command starting with abc 
!abc
 
# printing the last command starting with abc 
!abc:p
 
# reverse searching into the history
CTRL + R
 
# recording the date and time of each command in the history
HISTTIMEFORMAT="%d/%m/%y %T"
 
# making it persistent after reboot
echo "HISTTIMEFORMAT=\"%d/%m/%y %T\"" >> ~/.bashrc
# or
echo 'HISTTIMEFORMAT="%d/%m/%y %T"' >> ~/.bashrc
```

## WSL 

wsl --user root
You should be logged in as root into your WSL. Now, use the passwd command to change the password for your user:

passwd username
Replace username with your actual Linux username.

https://askubuntu.com/questions/1365074/trying-to-use-sudo-in-wsl-but-my-microsoft-account-which-im-logged-into-as-adm

# Getting root Access

On Linux there are 2 main categories of users:
1. non-privileged users - have no special rights on the system.
2. The root user (superuser or the administrator).

● Root privileges are the powers that the root account has on the system. The root
account is the most privileged on the system and has absolute power over it.

● Root exists on any Linux system is there’s only one.

● It’s not recommended to use root for ordinary tasks. When root permissions are needed
you simply become root only to perform that particular administrative task.

## Running commands as root (sudo, su)
```
 
# running a command as root (only users that belong to sudo group [Ubuntu] or wheel [CentOS])
sudo command
 
# becoming root temporarily in the terminal
sudo su      # => enter the user's password
 
# setting the root password
sudo passwd root
 
# changing a user's password
passwd username
 
# becoming root temporarily in the terminal
su     # => enter the root password
```

# The Linux File System

● A file system controls how data is stored and retrieved.
● Each group of data is called a file and the structure and the logic rules used to manage
files and their names are called file systems.
● A file system is a logical collection of files on a partition or disk.
● On a Linux system, everything is considered to be a file.
● On Linux file and directory names are case-sensitive.

# The Filesystem Hierarchy Standard

● /bin contains binaries or user executable files which are available to all users.
● /sbin contains applications that only the superuser (hence the initial s) will need.
● /boot contains files required for starting your system.
● /home is where you will find your users’ home directories. Under this directory there is another
directory for each user, if that particular user has a home directory.
root has its home directory separated from the rest of the users’ home directories and is /root
● /dev contains device files.
● /etc contains most, if not all system-wide configuration files.
● /lib contains shared library files used by different applications.
● /media is used for external storage will be automatically mounted.
● /mnt is like /media but it’s not very often used these days
● /tmp contains temporary files, usually saved there by applications that are running.
Non-privileged users may also store files here temporarily.
● /proc is a virtual directory. It contains information about your computer hardware, such as
information about your CPU, RAM memory or Kernel. The files and directories are generated
when your computer starts, or on the fly, as your system is running and things change.
● /sys contains information about devices, drivers, and some kernel features.
● /srv contains data for servers.
● /run is a temporary file system which runs in RAM.
● /usr contains many other subdirectories binaries files, shared libraries and so on. On some
distributions like CentOS many commands are saved in /usr/bin and /usr/sbin instead of /bin
and /sbin.
● /var typically contains variable-length files such as logs which are files that register events that
happen on the system.

