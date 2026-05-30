# Terraform Local Practice Lab

## Purpose

This repository is a local-only Terraform playground for learning Terraform without using any cloud provider.

It is designed for practicing the Terraform lifecycle on your own machine:

- `terraform init`
- `terraform fmt`
- `terraform validate`
- `terraform plan`
- `terraform apply`
- `terraform destroy`

The lab uses only local and lightweight providers, so you can learn Terraform concepts without AWS, OCI, Azure, or GCP.

---

## What this lab creates

This lab creates a local folder structure and a sample text file containing a Terraform-generated message.

It also generates a random suffix so you can see how Terraform manages changes and state over time.

Example artifacts:

- `./lab-output/`
- `./lab-output/lab-info.txt`

---

## Repository structure

    terraform-local-lab/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── terraform.tfvars.example
    ├── .gitignore
    └── README.md

---

## Prerequisites

Install Terraform locally and verify it works:

    terraform version

Recommended version:

- Terraform 1.5 or newer

---

## Configuration files

### main.tf

This file defines the providers and resources.

    terraform {
      required_version = ">= 1.5.0"

      required_providers {
        local = {
          source  = "hashicorp/local"
          version = "~> 2.5"
        }
        random = {
          source  = "hashicorp/random"
          version = "~> 3.6"
        }
      }
    }

    provider "local" {}
    provider "random" {}

    resource "random_string" "lab_id" {
      length  = var.random_id_length
      upper  = false
      lower  = true
      numeric = true
      special = false
    }

    resource "local_file" "lab_info" {
      filename = "${path.module}/${var.output_dir}/lab-info.txt"
      content = <<-EOT
      Terraform Local Practice Lab

      Project Name : ${var.project_name}
      Owner        : ${var.owner_name}
      Environment  : ${var.environment}
      Lab ID       : ${random_string.lab_id.result}

      This file was created by Terraform on your local machine.
      EOT
    }

    resource "local_file" "notes" {
      filename = "${path.module}/${var.output_dir}/notes.txt"
      content  = var.notes
    }

### variables.tf

This file defines reusable input values.

    variable "project_name" {
      description = "Name of the practice lab"
      type        = string
      default     = "terraform-local-lab"
    }

    variable "owner_name" {
      description = "Name of the user running the lab"
      type        = string
      default     = "devops-learner"
    }

    variable "environment" {
      description = "Environment label for the lab"
      type        = string
      default     = "local"
    }

    variable "output_dir" {
      description = "Directory where Terraform creates local files"
      type        = string
      default     = "lab-output"
    }

    variable "notes" {
      description = "Additional text to write into a file"
      type        = string
      default     = "This is a local Terraform practice lab."
    }

    variable "random_id_length" {
      description = "Length of the random string used in the lab"
      type        = number
      default     = 8
    }

### outputs.tf

This file prints useful values after apply.

    output "lab_id" {
      description = "Random ID created by Terraform"
      value       = random_string.lab_id.result
    }

    output "lab_info_file" {
      description = "Path to the generated info file"
      value       = local_file.lab_info.filename
    }

    output "notes_file" {
      description = "Path to the generated notes file"
      value       = local_file.notes.filename
    }

### terraform.tfvars.example

Copy this file to `terraform.tfvars` if you want to override defaults.

    project_name  = "terraform-local-lab"
    owner_name    = "kartheek"
    environment   = "local"
    output_dir    = "lab-output"
    notes         = "Practice lab created locally without any cloud provider."
    random_id_length = 8

### .gitignore

    .terraform/
    .terraform.lock.hcl
    terraform.tfstate
    terraform.tfstate.*
    *.tfvars
    lab-output/

---

## How to use

Initialize Terraform:

    terraform init

Format the code:

    terraform fmt

Validate the configuration:

    terraform validate

Preview what Terraform will do:

    terraform plan

Create the local lab:

    terraform apply

Confirm with:

    yes

After apply, check the generated files in `lab-output/`.

Example:

    cat lab-output/lab-info.txt
    cat lab-output/notes.txt

Remove everything created by Terraform:

    terraform destroy

Confirm with:

    yes

---

## What you will learn

This lab helps you understand:

- Terraform providers
- Resource lifecycle
- Variables
- Outputs
- State
- Idempotency
- Local resource management

---

## Terraform lifecycle summary

    Write code
        |
        v
    terraform init
        |
        v
    terraform fmt
        |
        v
    terraform validate
        |
        v
    terraform plan
        |
        v
    terraform apply
        |
        v
    terraform destroy

---

## Key takeaway

Terraform does not need a cloud provider to teach the core workflow.

This local lab is a safe way to practice the Terraform lifecycle and understand how Terraform manages resources and state.
