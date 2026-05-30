# Ansible Learning Guide

## Purpose

This document serves as a quick-reference guide for learning, revision, interview preparation, and day-to-day usage of Ansible.

By the end of this guide, you should understand:

- What Ansible is?
- Why organizations use Ansible?
- Ansible Architecture
- Inventories
- Playbooks
- Tasks
- Modules
- Variables
- Roles
- Ad-hoc Commands
- Ansible Lifecycle
- Best Practices
- Common Interview Questions

---

# What is Ansible?

Ansible is an open-source automation tool used for:

- Configuration Management
- Infrastructure Provisioning
- Application Deployment
- Server Management
- Security Compliance

Ansible is developed by Red Hat and uses YAML-based Playbooks to automate tasks.

---

# Why Ansible?

Without Ansible:

    Server1 → Manual Configuration
    Server2 → Manual Configuration
    Server3 → Manual Configuration

Problems:

- Time consuming
- Human errors
- Configuration drift
- Difficult maintenance

With Ansible:

    Ansible Playbook
           |
           v
    Server1
    Server2
    Server3

Benefits:

- Consistency
- Automation
- Scalability
- Faster deployments

---

# Ansible Architecture

Ansible follows an Agentless Architecture.

    +--------------------+
    | Control Node       |
    | (Ansible Server)   |
    +---------+----------+
              |
              | SSH
              |
      +-------+-------+
      |               |
      v               v

    Server1        Server2

Components:

1. Control Node
2. Inventory
3. Playbook
4. Managed Nodes
5. Modules

---

# Key Components

## Control Node

Machine where Ansible is installed.

Responsibilities:

- Executes playbooks
- Stores inventories
- Connects to remote servers

---

## Managed Node

Target machine managed by Ansible.

Examples:

- Linux Servers
- Cloud VMs
- Containers

---

## Inventory

Inventory defines target hosts.

Example:

    [webservers]
    server1
    server2

    [dbservers]
    db1

---

## Playbook

Playbooks are YAML files containing automation tasks.

Example:

    ---
    - hosts: webservers
      tasks:
        - name: Install Nginx
          package:
            name: nginx
            state: present

---

## Task

A single action performed by Ansible.

Examples:

- Install package
- Create file
- Restart service
- Copy configuration

---

## Module

Modules perform the actual work.

Examples:

| Module | Purpose |
|----------|----------|
| copy | Copy files |
| file | Manage files |
| package | Install packages |
| service | Manage services |
| user | Manage users |
| shell | Execute shell commands |
| command | Execute commands |
| debug | Print messages |
| setup | Gather facts |

---

# Ansible Inventory Types

## Static Inventory

Defined manually.

Example:

    [webservers]
    192.168.1.10
    192.168.1.11

---

## Dynamic Inventory

Generated automatically from:

- OCI
- AWS
- Azure
- GCP
- VMware

Useful for cloud environments where servers are created dynamically.

---

# Ansible Playbook Structure

Basic Playbook:

    ---
    - name: Install Nginx
      hosts: webservers
      become: yes

      tasks:

      - name: Install package
        package:
          name: nginx
          state: present

      - name: Start service
        service:
          name: nginx
          state: started

---

# Variables

Variables improve reusability.

Example:

    app_port: 8080
    app_name: myapp

Usage:

    {{ app_name }}

Benefits:

- Reusability
- Environment-specific configuration
- Easier maintenance

---

# Facts

Facts are system information gathered automatically.

Examples:

- OS Version
- CPU Count
- Memory
- IP Address

View facts:

    ansible all -m setup

---

# Ad-Hoc Commands

Useful for one-time tasks.

Ping Hosts:

    ansible all -m ping

Check Uptime:

    ansible all -a "uptime"

Install Package:

    ansible webservers -m package -a "name=nginx state=present"

Restart Service:

    ansible webservers -m service -a "name=nginx state=restarted"

Create Directory:

    ansible all -m file -a "path=/tmp/demo state=directory"

---

# Ansible Lifecycle

Typical workflow:

    Write Inventory
          |
          v
    Write Playbook
          |
          v
    Syntax Check
          |
          v
    Dry Run
          |
          v
    Execute
          |
          v
    Verify
          |
          v
    Re-Execute

---

## Step 1: Verify Installation

    ansible --version

Purpose:

- Verify installation
- Check Ansible version

---

## Step 2: Verify Inventory

    ansible all --list-hosts -i inventory.ini

Purpose:

- Verify inventory
- Verify reachable hosts

---

## Step 3: Ping Hosts

    ansible all -m ping

Expected:

    pong

Purpose:

- Test connectivity

---

## Step 4: Syntax Check

    ansible-playbook playbook.yml --syntax-check

Purpose:

- Validate YAML
- Detect errors before execution

---

## Step 5: Dry Run

    ansible-playbook playbook.yml --check

Purpose:

- Preview changes
- No actual modifications

Comparable to:

    terraform plan

---

## Step 6: Execute Playbook

    ansible-playbook playbook.yml

Purpose:

- Apply desired configuration

Example Output:

    PLAY RECAP

    server1 : ok=3 changed=1 failed=0

---

## Step 7: Verify Changes

Examples:

    systemctl status nginx

    cat /etc/nginx/nginx.conf

---

## Step 8: Re-run Playbook

    ansible-playbook playbook.yml

Expected:

    changed=0

Why?

Ansible is idempotent.

---

# What is Idempotency?

One of the most important Ansible concepts.

Running:

    ansible-playbook playbook.yml

multiple times produces the same desired state.

Example:

Install nginx:

First run:

    changed=1

Second run:

    changed=0

No duplicate actions occur.

---

# Ansible Roles

Roles help organize large projects.

Structure:

    roles/
    ├── nginx
    │   ├── tasks
    │   ├── handlers
    │   ├── vars
    │   ├── defaults
    │   └── templates

Benefits:

- Reusable
- Maintainable
- Modular

---

# Ansible Tags

Run specific tasks only.

Example:

    ansible-playbook site.yml --tags nginx

Benefits:

- Faster execution
- Targeted deployments

---

# Best Practices

1. Use Roles
2. Use Variables
3. Avoid Hardcoded Values
4. Use Meaningful Task Names
5. Use Version Control
6. Store Secrets in Ansible Vault
7. Test with --check
8. Keep Playbooks Idempotent

---

# Common Interview Questions

### What is Ansible?

Ansible is an agentless automation tool used for configuration management and infrastructure automation.

---

### Why is Ansible Agentless?

Ansible uses SSH and does not require agents on target machines.

---

### What is Inventory?

A file containing target hosts managed by Ansible.

---

### What is a Playbook?

A YAML file containing automation tasks.

---

### What is a Module?

A reusable unit of work executed by Ansible.

Examples:

- copy
- file
- service
- package

---

### What is Idempotency?

Running the same playbook multiple times results in the same desired state.

---

### Difference Between Command and Shell Module?

Command:

    command: uptime

Shell:

    shell: cat file.txt | grep error

Shell supports shell operators.

Command does not.

---

### What is Ansible Vault?

Tool used to encrypt sensitive information such as:

- Passwords
- API Keys
- Secrets

---

# Quick Revision Cheat Sheet

Installation:

    ansible --version

Ping Hosts:

    ansible all -m ping

Gather Facts:

    ansible all -m setup

Syntax Check:

    ansible-playbook site.yml --syntax-check

Dry Run:

    ansible-playbook site.yml --check

Execute:

    ansible-playbook site.yml

Run Tags:

    ansible-playbook site.yml --tags nginx

---

# Key Takeaway

Ansible is a simple, agentless automation tool that uses inventories, playbooks, modules, and variables to automate infrastructure and configuration management.

Mastering:

- Inventories
- Playbooks
- Modules
- Variables
- Roles
- Idempotency
- Ansible Lifecycle

provides a strong foundation for DevOps, Cloud Engineering, Site Reliability Engineering (SRE), and Infrastructure Automation.
