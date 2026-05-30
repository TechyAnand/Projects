# Terraform + Ansible Infrastructure Provisioning Automation

## Purpose

This guide explains how Terraform and Ansible can work together for infrastructure provisioning and configuration automation.

It is written for learning and review purposes, especially for DevOps and platform engineering workflows.

You will learn:

- What Terraform does
- What Ansible does
- Why they are often used together
- How Terraform can call Ansible
- A simple practical workflow
- Important best practices
- Common pitfalls

---

## Big Picture

The usual division of responsibility is:

- **Terraform** = creates infrastructure
- **Ansible** = configures infrastructure

A common workflow looks like this:

    Terraform
        |
        v
    Create VM / Network / Storage
        |
        v
    Ansible
        |
        v
    Install packages / configure OS / deploy apps

This keeps the responsibilities clean and easier to maintain.

---

## Why Use Both?

Terraform is strong at:

- provisioning cloud resources
- creating compute instances
- building networks
- managing infrastructure state

Ansible is strong at:

- installing packages
- editing config files
- managing services
- applying OS-level configuration
- deploying application settings

Together, they provide a complete automation flow.

---

## Recommended Design

The best practice is:

1. Use Terraform to provision the infrastructure.
2. Use Terraform outputs to capture IP addresses, hostnames, or other connection details.
3. Use Ansible to configure the provisioned machines.

This is usually better than putting all application setup logic inside Terraform.

---

## Important Note

Calling Ansible directly from Terraform is possible, but it should be used carefully.

Terraform is primarily an infrastructure tool, not a configuration management tool.

If you call Ansible from Terraform, treat it as a convenience for small labs or learning environments.

For production, it is often better to run Terraform and Ansible as separate steps in a pipeline.

---

## Ways to Combine Terraform and Ansible

There are three common patterns:

### 1. Terraform first, Ansible second

Terraform provisions infrastructure.

Ansible is executed after Terraform finishes.

This is the cleanest and most common approach.

### 2. Terraform invokes Ansible with local-exec

Terraform runs an Ansible command using a provisioner.

This is useful for demos and labs.

### 3. CI/CD pipeline orchestrates both

A pipeline runs:

- Terraform apply
- Ansible playbook
- validation checks

This is often the best enterprise pattern.

---

## Example Workflow

    terraform init
    terraform plan
    terraform apply
    ansible-playbook -i inventory.ini site.yml

If you want Terraform to trigger Ansible automatically, you can use `local-exec`.

---

## Example 1: Terraform creates infrastructure

This example shows a simple VM or server creation pattern. The exact resource depends on your platform.

Terraform outputs connection details like:

- public IP
- private IP
- hostname
- ssh user

Example output block:

```hcl
output "app_server_ip" {
  value = oci_core_instance.app.public_ip
}
```

or:

```hcl
output "server_ip" {
  value = aws_instance.app.public_ip
}
```

or for a local lab:

```hcl
output "server_ip" {
  value = "192.168.1.10"
}
```

---

## Example 2: Terraform calls Ansible

The `local-exec` provisioner can run a command from the machine where Terraform is executed.

### Example Terraform snippet

```hcl
resource "null_resource" "configure_server" {
  depends_on = [null_resource.wait_for_server]

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini site.yml"
  }
}
```

### What this does

After Terraform finishes provisioning the infrastructure, it runs:

```bash
ansible-playbook -i inventory.ini site.yml
```

from the local machine.

---

## Better Example with Terraform Outputs

Terraform can write an inventory file or provide values that Ansible uses.

### Terraform output

```hcl
output "server_ip" {
  value = aws_instance.web.public_ip
}
```

### Inventory example

```ini
[web]
server1 ansible_host=1.2.3.4 ansible_user=ubuntu
```

Then run:

```bash
ansible-playbook -i inventory.ini site.yml
```

---

## Example 3: Create inventory from Terraform

A simple lab pattern is:

1. Terraform provisions the server.
2. Terraform writes an inventory file.
3. Ansible uses that inventory file.

Example using `local_file`:

```hcl
resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"
  content  = <<-EOT
  [web]
  app1 ansible_host=${aws_instance.web.public_ip} ansible_user=ubuntu
  EOT
}
```

This makes it easier to hand off Terraform outputs to Ansible.

---

## Example 4: Terraform + Ansible in a local lab

If you are using local containers or VMs, Terraform can still be used to create the environment and Ansible can configure it.

Typical local lab flow:

    Terraform creates containers / VMs
        |
        v
    Terraform exports inventory
        |
        v
    Ansible configures services
        |
        v
    Validate with curl / browser / logs

---

## Using local-exec

The `local-exec` provisioner runs a local shell command.

### Example

```hcl
resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini site.yml"
  }
}
```

### Pros

- simple
- easy for demos
- quick to understand

### Cons

- mixes provisioning and configuration
- harder to debug
- may re-run unexpectedly
- less ideal for production workflows

---

## Using remote-exec

Terraform also has `remote-exec`, but it is usually not the best way to manage application configuration.

It is typically used for:

- bootstrapping
- simple setup
- one-time initialization

Ansible is usually a better choice for ongoing configuration tasks.

---

## Recommended Production Pattern

The preferred production design is:

    Terraform
        |
        v
    Provision Infrastructure
        |
        v
    Save Outputs / Inventory
        |
        v
    CI/CD Pipeline
        |
        v
    Ansible Configuration
        |
        v
    Validation
        |
        v
    Monitoring

This keeps each tool focused on its strength.

---

## Example CI/CD Flow

    Git Commit
        |
        v
    Terraform Apply
        |
        v
    Capture Outputs
        |
        v
    Generate Inventory
        |
        v
    Ansible Playbook
        |
        v
    Smoke Test

This is a very common DevOps automation model.

---

## Sample Ansible Playbook

```yaml
---
- name: Configure servers
  hosts: web
  become: true

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
        update_cache: true

    - name: Start nginx
      service:
        name: nginx
        state: started
        enabled: true
```

---

## Sample Terraform + Ansible Sequence

### Terraform

```hcl
resource "null_resource" "configure" {
  depends_on = [aws_instance.web]

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini site.yml"
  }
}
```

### Ansible

```yaml
---
- name: Configure server
  hosts: web
  become: true

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
```

---

## When This Pattern Makes Sense

Use Terraform calling Ansible when:

- you are building a learning lab
- you want a quick demo
- you need a simple bootstrap flow
- the environment is small and controlled

Avoid it when:

- you need strong separation of concerns
- the pipeline is complex
- you want easy re-runs and idempotent orchestration
- you are managing large production systems

---

## Best Practices

1. Use Terraform for infrastructure only.
2. Use Ansible for configuration only.
3. Keep inventories generated from Terraform outputs when possible.
4. Avoid putting too much shell logic into Terraform.
5. Prefer CI/CD orchestration over direct Terraform-to-Ansible coupling.
6. Keep playbooks idempotent.
7. Use variables instead of hardcoding IPs and usernames.
8. Store sensitive values securely.
9. Test in a local lab before production.
10. Document the flow clearly in README files.

---

## Common Problems

### Problem: Ansible runs before infrastructure is ready

Fix:

- add explicit dependencies
- wait for SSH to become available
- use retries or a readiness check

### Problem: Hardcoded IP addresses

Fix:

- use Terraform outputs
- generate inventory dynamically

### Problem: Terraform state and configuration drift

Fix:

- use Terraform only for provisioning
- use Ansible for OS/app configuration
- keep each tool in its own job or stage

### Problem: Repeated executions

Fix:

- make playbooks idempotent
- use proper Terraform dependencies
- avoid unnecessary `null_resource` triggers

---

## Simple Learning Example

A practical local learning flow can be:

1. Terraform creates two Linux instances or containers.
2. Terraform exports their IPs or hostnames.
3. Terraform writes an inventory file.
4. Ansible installs and configures nginx.
5. You verify access using curl.

This gives hands-on understanding of how provisioning and configuration automation fit together.

---

## Interview Notes

### What is the role of Terraform?

Terraform provisions infrastructure resources.

### What is the role of Ansible?

Ansible configures operating systems and applications.

### Why should they not always be mixed?

Because they solve different problems and mixing them can make automation harder to maintain.

### What is `local-exec`?

A Terraform provisioner that runs a command on the machine executing Terraform.

### Is calling Ansible from Terraform a best practice?

Usually no, not for production. It is acceptable for small labs, demos, or controlled bootstrap tasks.

---

## Key Takeaway

Terraform and Ansible work well together when each tool is used for its strength:

- Terraform creates infrastructure
- Ansible configures that infrastructure

Calling Ansible from Terraform is possible, but the cleanest approach is to let Terraform provision resources and then run Ansible as a separate configuration step.

This design is easier to maintain, easier to debug, and better suited for real-world DevOps automation.
