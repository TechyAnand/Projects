# Ansible Playground Using Docker

## Purpose

This repository creates a small local Ansible lab using Docker and Docker Compose.

It is designed for learning, revision, and hands-on practice.

The lab gives you:

- one Ansible controller container
- two SSH-enabled target containers
- a safe local environment for testing playbooks
- a simple setup you can run on your laptop

This is useful for practicing:

- ad-hoc commands
- inventory files
- playbooks
- variables
- facts
- file tasks
- package tasks
- privilege escalation
- basic automation workflows

---

## Files

    Dockerfile
    docker-compose.yml
    inventory.ini
    playbook.yml
    README.md

---

## What each container does

### controller

This is the Ansible machine.

It includes:

- Ansible
- SSH client tools
- sshpass
- common editor and utility packages

Use this container to run:

    ansible
    ansible-playbook
    ansible-inventory

### target1 and target2

These are managed nodes.

They include:

- OpenSSH server
- Python 3
- sudo
- a ready-to-use user named ansible

Default login for learning purposes:

    username: ansible
    password: ansible

---

## Why this setup is useful

In real Ansible usage, the control node connects to target machines over SSH.

This playground simulates that flow locally, so you can practice without needing cloud servers or virtual machines.

---

## How to start

Build and start the lab:

    docker compose up -d --build

Check the running containers:

    docker compose ps

Open a shell in the controller:

    docker compose exec controller bash

---

## Inventory file

The inventory file is used to tell Ansible which hosts to manage.

### inventory.ini

    [targets]
    target1 ansible_host=target1 ansible_user=ansible ansible_password=ansible ansible_connection=ssh ansible_become=true ansible_become_password=ansible
    target2 ansible_host=target2 ansible_user=ansible ansible_password=ansible ansible_connection=ssh ansible_become=true ansible_become_password=ansible

    [all:vars]
    ansible_python_interpreter=/usr/bin/python3

### What it means

- `target1` and `target2` are the managed hosts
- `ansible_host` tells Ansible how to reach them on the Docker network
- `ansible_user` and `ansible_password` are the SSH login credentials
- `ansible_become=true` enables privilege escalation
- `ansible_python_interpreter` points Ansible to Python 3 inside the target containers

---

## Playbook file

The playbook shows a basic end-to-end automation flow.

### playbook.yml

    ---
    - name: Ansible Playground Demo
      hosts: targets
      become: true

      tasks:
        - name: Verify connectivity
          ping:

        - name: Display hostname
          command: hostname
          register: hostname_output

        - name: Print hostname
          debug:
            msg: "Current Host: {{ hostname_output.stdout }}"

        - name: Create demo directory
          file:
            path: /tmp/ansible-demo
            state: directory
            mode: '0755'

        - name: Create welcome file
          copy:
            dest: /tmp/ansible-demo/welcome.txt
            content: |
              ==================================
              Welcome to Ansible Playground
              Managed by Ansible
              ==================================

        - name: Gather operating system details
          debug:
            msg:
              - "Hostname: {{ ansible_hostname }}"
              - "OS Family: {{ ansible_os_family }}"
              - "Distribution: {{ ansible_distribution }}"
              - "Version: {{ ansible_distribution_version }}"

        - name: Verify file creation
          stat:
            path: /tmp/ansible-demo/welcome.txt
          register: file_status

        - name: Print file status
          debug:
            var: file_status.stat.exists

### What it does

The playbook:

- checks connectivity with `ping`
- prints the hostname
- creates a directory
- writes a file
- shows host facts
- checks whether the file exists

---

## First things to try

From inside the controller container:

    ansible -i inventory.ini targets -m ping

    ansible -i inventory.ini targets -m setup

    ansible -i inventory.ini targets -a "hostname"

Run the playbook:

    ansible-playbook -i inventory.ini playbook.yml

If you want to use sudo in a playbook, the ansible user already has passwordless sudo inside the target containers.

---

## Sample output idea

After running the playbook, you should see a file created on each target:

    /tmp/ansible-demo/welcome.txt

Expected content:

    ==================================
    Welcome to Ansible Playground
    Managed by Ansible
    ==================================

---

## Docker image layout

The Dockerfile contains two useful targets:

- controller
- target

The controller target installs Ansible and command-line tools.

The target target installs SSH and Python so Ansible can manage it.

---

## Useful commands

Stop the lab:

    docker compose down

Stop and remove images:

    docker compose down --rmi local

Rebuild after changes:

    docker compose up -d --build

View logs:

    docker compose logs -f

---

## Notes

- Host key checking is disabled in the controller for a smoother learning experience.
- The target containers are intentionally simple and meant only for local practice.
- You can add more target services by copying the target definition in docker-compose.yml.
- You can also expand this lab later with roles, handlers, templates, and vault.

---

## Learning outcomes

After using this playground, you should be comfortable with:

- connecting to hosts with Ansible
- writing inventories
- running ad-hoc commands
- testing playbooks locally
- understanding SSH-based automation
- practicing idempotent configuration changes

---

## Key takeaway

Docker makes it easy to create a repeatable Ansible practice environment.

This small lab is a safe way to learn Ansible before using it on real servers.
