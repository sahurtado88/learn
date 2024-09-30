Challenge #1

Run the following command both as a non-privileged user and as root: tail /etc/shadow

Use the TAB key for auto-completion.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #2

Become root temporarily in a terminal.

Run the following command as root: apt update && apt install nmap

Logout root from the terminal using a keyboard shortcut

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #3

Change (set) the root password

Become root in a terminal by running the su command

Run as root the following command: lshw

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #4

Consider the nmap program installed in a previous challenge. Open its man page and search for the option -sV

Run as root: nmap -sV -p 80 www.example.com

Find the IP address of your Default Gateway running route -n and then run as root: nmap -sV -p 80,443 default_gateway_ip (Example: nmap -sV -p 80,443 192.168.0.1)

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #5

Display the user’s history

Remove line no. 4 from the history

Run a command without being recorded in history. Check that it wasn’t saved in the shell history.

Remove the entire history.

Are you stuck? Do you want to see the solution to this challenge?? Click here.


Challenges - Paths, ls, File Timestamps and Types, Viewing Files
How to solve these challenges:

To be consistent with the filenames and paths run the commands on Ubuntu

Write your solution in a terminal and test it.

If your solution is not correct, then try to understand the error messages, watch the video again, rewrite the solution, and test it again. Repeat this step until you get the correct solution.

Save the solution in a file for future reference or recap.



Challenge #1

Move into the current user’s home directory using the cd command.

List the contents of /etc using the ls command and an absolute path.

Display the contents of /var/log/dmesg using the cat command and an absolute path.

Move into the root directory (/) using an absolute path.

List the contents of /etc using the ls command and an absolute path.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #2

Move into the current user’s home directory using the cd command and an absolute path.

List the contents of the current directory using the ls command and a relative path.

List the contents of /home using the ls command and an absolute path.

List the contents of /home using the ls command and a relative path.

List the contents of /etc using the ls command and an absolute path.

List the contents of /etc using the ls command and a relative path.

Display the contents of /var/log/dmesg using the cat command and an absolute path.

Display the contents of /var/log/dmesg using the cat command and a relative path.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #3

Move into the root directory (/) using the cd command and an absolute path.

Display the contents of /var/log/boot.log using the cat command and a relative path.

Run the previous command as root.

Move to /var/log directory using an absolute path.

Display the contents of the Desktop directory using both an absolute and relative path.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #4

Display the man page of ls and search for -d option.

Display the contents of /var/log using a long listing format.

Display information about the /var/log directory in a long listing format.

Display the contents of /etc on a single column.

Display all the files and directories (including hidden ones) from the user's home directory.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #5

Display the contents of /var/log sorted by size in a human-readable format.

Rerun the previous command adding an option that omits the files that end in .log from listing.

List the contents of /etc recursively.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #6

Create a new file called linux.txt in the user’s home directory using the touch command.

Notice the file timestamps using both stat and ls commands.

Display the entire timestamp of the file using the ls command.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #7

Consider the file created in the previous challenge. Notice its timestamps and then update them to the system’s current date and time.

Change only the modification and change time to the current system time. See the change.

Change only the modification time manually to 1990, January 15, 10:30:55 AM.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #8

Consider the file called linux.txt created in the previous challenge. Notice its timestamps and then update them to the values of /etc/passwd. See the changes.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #9

List the contents of /var/log displaying the access time of the files and sorting by filenames in reverse order.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #10

Notice and try to recognize all Linux file types by running ls -l, ls -F and file commands.

Run the commands on the following files:

/etc/passwd

/var

/vmlinuz

/usr/bin/ls

/dev/sda1

/dev/tty1

/run/initctl

/run/snapd.socket

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #11

List the contents of /var/log/dmesg using the cat command and display the line numbers as well.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #12

Display the contents of /etc/ssh/ssh_config page by page using less.

Go to the end and then to the beginning of the file using the right shortcuts.

Search forward for the string Ciphers

Quit less

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #13

Display the first 3 lines of /etc/passwd

Display the last 5 lines of /etc/shadow

Display the contents of /etc/group starting with line 5

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #14

Display the last 12 lines of /var/log/auth.log in real-time.

Become root in another terminal and notice how the display is automatically updated.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #15

Display the contents of the user’s home directory repeatedly every 2 seconds.

Create a new file in the user's home directory and notice the differences between the refreshes.

Are you stuck? Do you want to see the solution to this challenge? Click here.

Install the tree command which is necessary.

Using shell commands create the following directory structure.




Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #2

Considering this directory structure, copy the file called security.txt to the updates directory.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #3

Considering the solution from the previous challenge remove the file called security.txt from the directory called updates.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #4

Considering the initial directory structure, copy the directory called updates from centos to ubuntu.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #5

Considering the solution from the previous challenge, remove the directory called updates from the ubuntu directory.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #6

Considering the initial directory structure and using only one command copy the file called apt.txt and the directory called updates to linux directory.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #7

Considering the solution from the previous challenge remove the file called apt.txt and the directory called updates from the linux directory interactively (by prompting the user).

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #8

Considering the initial directory structure, rename the directory called centos to redhat and then back to centos.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #9

Considering the initial directory structure, copy the file called security.txt to ubuntu directory as sec.txt

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #10

Create a file named users.txt by redirecting the output of the who command.

Display the file contents.

Remove the file in a secure manner by overwriting the file 50 times before removing it.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #11

Remove the entire directory structure without prompting.

Are you stuck? Do you want to see the solution to this challenge? Click here.

Challenges - tar, ln
How to solve these challenges:

To be consistent with the filenames and paths run the commands on Ubuntu

Write your solution in a terminal and test it.

If your solution is not correct, then try to understand the error messages, watch the video again, rewrite the solution, and test it again. Repeat this step until you get the correct solution.

Save the solution in a file for future reference or recap.



Challenge #1

Using tar, create an archive of /etc in the current directory.

Display the contents of the archive searching for a specific file in the archive.

Extract the archive in the current directory.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #2

Using tar, create a compressed archive of /etc using gzip in the current directory.

Display the contents of the archive searching for a specific file in the archive.

Extract the archive in another directory.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #3

Create a file using a command redirection and a directory.

Create 2 hard links to the file. Check the no. of hard links.

Create a symlink to the initial file. Check the symlink.

Delete the initial file and see what happens with the other 2 hard links and with the symlink.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #4

Create a symlink to the Desktop directory in another directory.

Create a hard link to the Desktop directory in another directory.

Are you stuck? Do you want to see the solution to this challenge? Click here.

Challenges - locate, find
How to solve these challenges:

To be consistent with the filenames and paths run the commands on Ubuntu

Write your solution in a terminal and test it.

If your solution is not correct, then try to understand the error messages, watch the video again, rewrite the solution, and test it again. Repeat this step until you get the correct solution.

Save the solution in a file for future reference or recap.



Challenge #1

Check if locate is installed. Install it if necessary.

Create a new file and search for it using locate.

Update the database used by locate and search for the file again.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #2

Remove the file created in the previous challenge.

Search for it using locate.

Update the database used by locate and search for the file again.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #3

Find all regular files in /var that have a size bigger than 2 MB.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #4

Find all regular files in /etc that have been modified in the last hour.

Execute cat on each found file.

Create a new directory and copy all found files in that directory (backup).

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #5

Find all regular files in /var that are not owned by root.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #5

Create a directory and a new file in it.

Find all files that have the change time in the last minute in the newly created directory and delete them automatically.

Are you stuck? Do you want to see the solution to this challenge? Click here.

# Challenges - File Permissions
How to solve these challenges:

To be consistent with the filenames and paths run the commands on Ubuntu

Write your solution in a terminal and test it.

If your solution is not correct, then try to understand the error messages, watch the video again, rewrite the solution, and test it again. Repeat this step until you get the correct solution.

Save the solution in a file for future reference or recap.



Create a directory with a regular file in it. Work as a non-privileged user.




Challenge #1

Display the permissions of ubuntu.txt

Remove all permissions of others.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #2

Remove the read permission of ubuntu.txt for the owner and check if the owner can read the file.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #3

Using the octal notation, set the permissions of the directory to rwxrwx--- and of the file to rw-r-----

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #4

Set the permissions of the directory to 0667. Check if the user (owner) can list its contents, move to the directory and remove it.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #5

Set the permissions of all the files in the user's home directory to 0640 and the permissions of all directories to 0750.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #6

As a non-privileged user list the contents of /root using the ls command. See what will happen.

As root set SUID to ls and list the contents of /root again as a non-privileged user.

Check the SUID permission set on ls

As root remove the SUID bit.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #7

Set the directory permissions to 0777 and the file permissions to 0000. As another non-privileged user, try to remove the file.

Create a new file in the directory and set its permissions to 0644.

Set the Sticky Bit on the directory.

As another non-privileged user, try to remove the file.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #8

Change the owner and the group owner of all files in the current user home directory to the current user and its primary group.

Are you stuck? Do you want to see the solution to this challenge? Click here.
