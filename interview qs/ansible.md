# Ansible
In Ansible, modules are small programs written in Python that Ansible uses to perform specific tasks on managed systems. Modules can perform a wide variety of tasks, from package management and service configuration to file manipulation and user management.

In Ansible, roles are a way to organize and structure your playbooks and tasks into logical, reusable units. Roles in Ansible allow you to modularize system configuration and automation, making it easier to manage and maintain your infrastructure.



1. What is Ansible?
Ansible is an open-source platform that facilitates configuration management, task automation, or application deployment. It is a valuable DevOps tool. It was written in Python and powered by Red Hat. It uses SSH to deploy SSH without incurring any downtime.

2. List Ansible’s advantages
Ansible has many strengths, including:

- It’s agentless and only requires SSH service running on the target machines
- Python is the only required dependency and, fortunately, most systems come with the language pre-installed
- It requires minimal resources, so there’s low overhead
- It’s easy to learn and understand since Ansible tasks are written in YAML.
- Unlike other tools, most of which are Procedural, ansible is declarative; define the desired state, and Ansible fulfills the requirements needed to achieve it
- Ansible is an ideal tool for CI/CD processes, providing a stable infrastructure for provisioning the target environment and then deploying the application to it.

3. Describe how Ansible works.
ansible is broken down into two types of servers: controlling machines and nodes. Ansible is installed on the controlling computer, and the controlling machines manage the nodes via SSH. 

The controlling machine contains an inventory file that holds the node system’s location. Ansible runs the playbook on the controlling machine to deploy the modules on the node systems. Since Ansible is agentless, there’s no need for a third-party tool to connect the nodes.

# 4. “playbook” is.

A playbook has a series of YAML-based files that send commands to remote computers via scripts. Developers can configure entire complex environments by passing a script to the required systems rather than using individual commands to configure computers from the command line remotely. Playbooks are one of Ansible’s strongest selling points and often referred to as the tool’s building blocks.

5. What is “idempotency”?

idempotency is an important Ansible feature. It prevents unnecessary changes in the managed hosts. With idempotency, you can execute one or more tasks on a server as many times as you need to, but it won’t change anything that’s already been modified and is working correctly. To put it in basic terms, the only changes added are the ones needed and not already in place.

6. Ansible Galaxy?

This is a tool bundled with Ansible to create a base directory structure. Galaxy is a website that lets users find and share Ansible content. You can use this command to download roles from the website:

7. Ansible to create encrypted files?

To create an encrypted file, use the ‘ansible-vault create’ command.

$ ansible-vault create filename.yaml

You will get a prompt to create a password, and then to type it again for confirmation. You will now have access to a new file, where you can add and edit data.

#  What are “facts” in the context of Ansible?

Facts are newly discovered and known system variables, found in the playbooks, used mostly for implementing conditionals executions. Additionally, they gather ad-hoc system information.

9. Explain what an ask_pass module is.

It’s a playbook control module used to control a password prompt. It’s set to True by default.

10. What’s an ad hoc command?

Users initiate ad hoc commands to initiate actions on a host without using a playbook. Consider it a one-shot command.

11. Explain the difference between a playbook and a play.

A play is a set of tasks that run on one or more managed hosts. Plays consist of one or more tasks. A playbook consists of one or more plays.

Playbook:

- A playbook is a YAML file that defines a set of configurations, tasks, and plays to be executed by Ansible.
It can contain multiple plays, each targeting different groups of hosts or servers.
- Playbooks are the main mechanism used to orchestrate and automate tasks in Ansible.
- Playbooks can include variables, roles, tasks, handlers, and other directives to define the desired state of the infrastructure.

Play:

- A play is a section within a playbook that defines a set of tasks to be executed on a group of hosts.
- Each play targets a specific group of hosts defined in the inventory file.
- A play consists of a list of tasks, along with optional directives such as variables, handlers, and roles.
- Plays are executed sequentially, one after the other, in the order they appear in the playbook.

Task:

- A task is a single unit of work to be performed by Ansible.
- Tasks are defined within plays and represent individual steps to be executed on remote hosts.
- Each task typically performs a specific action, such as installing a package, copying a file, restarting a service, etc.
- Tasks are written in YAML format and can include modules, parameters, conditionals, loops, and other directives.

12. What exactly is a configuration management tool?

Configuration management tools help keep a system running within the desired parameters. They help reduce deployment time and substantially reduce the effort required to perform repetitive tasks. Popular configuration management tools on the market today include Chef, Puppet, Salt, and of course, Ansible.

13. What’s a handler?

In Ansible, a handler is similar to a regular task in a playbook, but it will only run if a task alerts the handler. Handlers are automatically loaded by roles/<role_name>/handlers/main.yaml. Handlers will run once, after all of the tasks are completed in a particular play.

Sometimes you want a task to run only when a change is made on a machine. For example, you may want to restart a service if a task updates the configuration of that service, but not if the configuration is unchanged. Ansible uses handlers to address this use case. Handlers are tasks that only run when notified.

```
---
- name: Install Apache on RHEL server
  hosts: all
  tasks:
   - name: Install latest version of Apache
     yum:
      name: httpd
      state: latest
     notify:
      - start apache
  handlers:
     - name: start apache
       service:
         name: httpd
         state: restarted
```
In the preceding example, we install the most recent Apache package and then restart the service. However, if the most recent package is already present, the service will not be restarted. To accomplish this, we use handlers.

14. Explain a few of the basic terminologies or concepts in Ansible

A few of the basic terms that are commonly used while operating on Ansible are as follows:

- Controller Machine: The controller machine is responsible for provisioning servers that are being managed. It is the machine where Ansible is installed.
- Inventory: An inventory is an initialization file that has details about the different servers that you are managing.
- Playbook: It is a code file written in the YAML format. A playbook basically contains the tasks that need to be executed or automated.
- Task: Each task represents a single procedure that needs to be executed, e.g., installing a library.
- Module: A module is a set of tasks that can be executed. Ansible has hundreds of built-in modules, but you can also create custom ones.
- Role: An Ansible role is a predefined way of organizing playbooks and other files to facilitate sharing and reusing portions of provisioning.
- Play: A task executed from start to finish or the execution of a playbook is called a play.
- Facts: Facts are global variables that store details about the system such as network interfaces or operating systems.
- Handlers: Handlers are used to trigger the status of a service such as restarting or stopping a service.

15. Where are tags used?

A tag is an attribute that sets the Ansible structure, plays, tasks, and roles. When an extensive playbook is needed, it is more useful to run just a part of it as opposed to the entire thing. That is where tags are used.

16. Which protocol does Ansible use to communicate with Linux and Windows?

In Linux systems, the Secure Shell (SSH) protocol is employed, while Windows systems utilize the Windows Remote Management (WinRM) protocol.

17. What are ad hoc commands? Give an example.

Ad hoc commands are simple, one-line commands used to perform a certain task. You can think of ad hoc commands as an alternative to writing playbooks. An example of an ad hoc command is as follows:
```Command: ansible host -m netscaler -a "nsc_host=nsc.example.com user=apiuser password=apipass"
```

18. Define Ansible inventory and its types.

An Ansible inventory file is used to define hosts and groups of hosts upon which the tasks, commands, and modules in a playbook will operate.

In Ansible, there are two types of inventory files, namely static and dynamic, which are explained below:

- Static Inventory: Static inventory file is a list of managed hosts declared under a host group using either hostnames or IP addresses in a plain text file. The managed host entries are listed below the group name in each line.
- Dynamic Inventory: Dynamic inventory is generated by a script written in Python, any other programming language, or, preferably, using plug-ins. In a cloud setup, static inventory file configuration will fail since IP addresses change once a virtual server is stopped and started again.

# Step-by-Step Guide to Integrate Ansible Dynamic Inventory Plugin for AWS EC2 Instances

https://www.cloudthat.com/resources/blog/step-by-step-guide-to-integrate-ansible-dynamic-inventory-plugin-for-aws-ec2-instances

19. What is an Ansible vault?

Ansible vault is used to keep sensitive data, like passwords, rather than placing it as plain text in playbooks or roles. Any structured data file or single value inside a YAML file can be encrypted by Ansible.

20. How to generate encrypted passwords for a user module?

We can do this by using a small code, which is given below:

```
ansible all -i localhost, -m debug -a "msg={{ 'mypassword' | password_hash('sha512', 'mysecretsalt') }}"
```
We can also use the Passlib library in Python, which is mentioned below:


```
Command: python -c "from passlib.hash import sha512_crypt; import getpass; print(sha512_crypt.using(rounds=5000).hash(getpass.getpass()))"

```
21. Do you know how to turn off the facts in Ansible?

If you do not need any factual data about the hosts and you know everything about the systems centrally, then you may turn off fact gathering. This is advantageous when scaling Ansible in push mode with very large numbers of systems, mainly, or if we are using Ansible on experimental platforms. The following command can be used  to turn off the facts in Ansible:

```
Command:
- hosts: whatever
gather_facts: no
```


### role and module

Modules:

- Modules in Ansible are small pieces of code that are responsible for performing specific tasks on remote hosts.
- Each module is designed to perform a particular action, such as installing packages, managing files, configuring services, or interacting with cloud resources.
- Modules can be executed directly from the command line using the ansible or ansible-playbook commands, or they can be invoked within Ansible playbooks.
- Ansible provides a wide range of built-in modules that cover various aspects of system administration, network management, and cloud automation.
- Examples of Ansible modules include apt, yum, file, copy, service, docker_container, ec2_instance, etc.

Roles:

- Roles in Ansible are a way to organize and package related tasks, variables, handlers, and files into reusable units.
- A role encapsulates a set of playbooks, along with associated files and configurations, into a directory structure that follows a specific convention.
- Roles promote modularity and reusability by allowing you to define common configurations and tasks once and reuse them across multiple projects.
- Roles typically consist of a tasks directory (containing YAML files with task definitions), a vars directory (containing variable definitions), a handlers directory (containing handlers for triggering actions), and optionally other directories such as templates, files, or defaults.
- Roles can be included in Ansible playbooks using the roles keyword, allowing you to easily apply complex configurations to hosts.

In summary, while modules are individual units of functionality that perform specific tasks on remote hosts, roles are higher-level constructs that organize and package related tasks, variables, and configurations into reusable components. Modules provide the building blocks for performing actions, while roles provide a structured way to organize and manage configurations and tasks within Ansible playbooks.

https://www.youtube.com/watch?v=3id6l_BWdNA

