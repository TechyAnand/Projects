# Terraform Simple Demo

## Overview

This repository demonstrates a simple Terraform project that helps beginners understand the core Terraform workflow and lifecycle.

Instead of provisioning cloud resources, this example uses Terraform's local provider to create a file on your machine. This allows you to learn Terraform concepts without requiring AWS, OCI, Azure, or GCP accounts.

By completing this example, you will understand:

- Infrastructure as Code (IaC)
- Terraform configuration files
- Providers
- Resources
- Variables
- Outputs
- State management
- Terraform lifecycle commands

---

# What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool developed by HashiCorp.

Instead of manually creating infrastructure through a user interface, Terraform allows you to define infrastructure using code.

Terraform can manage:

- Virtual Machines
- Networks
- Storage
- Databases
- Kubernetes Clusters
- Cloud Resources
- Local Resources

Benefits include:

- Automation
- Consistency
- Version Control
- Reusability
- Faster Deployments

---

# Repository Structure

text terraform-simple-demo/ ├── main.tf ├── variables.tf ├── outputs.tf └── README.md 

---

# Terraform Configuration Files

## main.tf

Defines providers and resources.

hcl terraform {   required_version = ">= 1.5.0"    required_providers {     local = {       source  = "hashicorp/local"       version = "~> 2.5"     }   } }  provider "local" {}  resource "local_file" "example" {   filename = "${path.module}/hello.txt"   content  = var.file_message } 

---

## variables.tf

Defines input variables.

hcl variable "file_message" {   description = "Message written into the file"   type        = string   default     = "Hello from Terraform!" } 

---

## outputs.tf

Defines output values.

hcl output "created_file" {   description = "File created by Terraform"   value       = local_file.example.filename } 

---

# How This Example Works

The configuration creates a file named:

text hello.txt 

with the content:

text Hello from Terraform! 

Although this is a simple example, the same Terraform workflow is used for managing:

- AWS EC2 Instances
- OCI Compute Instances
- Azure Virtual Machines
- GCP Resources
- Kubernetes Clusters

The only difference is the provider being used.

---

# Prerequisites

Install Terraform:

https://developer.hashicorp.com/terraform/downloads

Verify installation:

bash terraform version 

Expected output:

text Terraform v1.x.x 

---

# Terraform Lifecycle

Terraform follows a structured lifecycle for managing infrastructure.

text Write Configuration          |          v terraform init          |          v terraform fmt          |          v terraform validate          |          v terraform plan          |          v terraform apply          |          v Infrastructure Created          |          v terraform output          |          v terraform plan          |          v terraform apply          |          v terraform destroy 

---

## Step 1: Initialize Terraform

bash terraform init 

### Purpose

Initializes the Terraform working directory.

### What Happens?

- Downloads providers
- Creates .terraform directory
- Creates lock file
- Prepares Terraform environment

Example:

text Terraform has been successfully initialized! 

---

## Step 2: Format Configuration

bash terraform fmt 

### Purpose

Formats Terraform code according to HashiCorp standards.

Benefits:

- Consistent formatting
- Easier code reviews
- Cleaner repositories

---

## Step 3: Validate Configuration

bash terraform validate 

### Purpose

Checks configuration syntax and correctness.

Example:

text Success! The configuration is valid. 

---

## Step 4: Review Changes

bash terraform plan 

### Purpose

Displays what Terraform will do before making any changes.

Example:

text Terraform will perform the following actions:  + create local_file.example 

Benefits:

- Safe preview
- No changes applied
- Helps identify mistakes

---

## Step 5: Create Resources

bash terraform apply 

Terraform displays the execution plan and requests confirmation.

Example:

text Plan: 1 to add, 0 to change, 0 to destroy. 

Confirm:

text yes 

Terraform creates the file.

---

## Step 6: View Current State

bash terraform show 

### Purpose

Displays Terraform-managed resources and current state.

Example:

text resource "local_file" "example" 

---

## Step 7: View Managed Resources

bash terraform state list 

Example:

text local_file.example 

### Why?

Terraform uses state to track infrastructure it manages.

---

## Step 8: View Outputs

bash terraform output 

Example:

text created_file = hello.txt 

Outputs are useful for displaying:

- Resource IDs
- URLs
- IP Addresses
- File Paths

---

## Step 9: Refresh State

bash terraform refresh 

### Purpose

Synchronizes Terraform state with actual infrastructure.

This is useful when resources are modified outside Terraform.

---

## Step 10: Destroy Resources

bash terraform destroy 

Terraform displays resources scheduled for deletion.

Example:

text Terraform will perform the following actions:  - destroy local_file.example 

Confirm:

text yes 

Terraform removes the file.

---

# Terraform State

Terraform stores infrastructure information inside:

text terraform.tfstate 

State contains:

- Resource IDs
- Current configuration
- Resource attributes
- Dependency information

Terraform uses state to determine:

- What exists
- What changed
- What should be updated
- What should be deleted

---

# Terraform Workflow Example

A typical workflow looks like this:

bash terraform init  terraform fmt  terraform validate  terraform plan  terraform apply  terraform output  terraform plan  terraform apply  terraform destroy 

---

# Verify the File Creation

After running:

bash terraform apply 

Verify:

bash cat hello.txt 

Expected output:

text Hello from Terraform! 

---

# Clean Up

Remove all resources created by Terraform:

bash terraform destroy 

Confirm when prompted:

text yes 

---

# Key Terraform Commands

| Command | Purpose |
|----------|----------|
| terraform init | Initialize Terraform |
| terraform fmt | Format configuration files |
| terraform validate | Validate configuration |
| terraform plan | Preview changes |
| terraform apply | Create or update resources |
| terraform show | Show current state |
| terraform state list | View managed resources |
| terraform output | Display outputs |
| terraform refresh | Synchronize state |
| terraform destroy | Remove resources |

---

# Benefits of Terraform

- Infrastructure as Code
- Repeatable Deployments
- Version Controlled Infrastructure
- Automated Provisioning
- Multi-Cloud Support
- Reduced Manual Errors
- Consistent Environments

---

# Key Takeaway

Terraform enables infrastructure management through code.

This simple project demonstrates the complete Terraform lifecycle using a local file resource. Once comfortable with this workflow, the same concepts can be applied to AWS, OCI, Azure, GCP, Kubernetes, and other infrastructure platforms.

Understanding the Terraform lifecycle is the foundation for modern DevOps and Cloud Engineering practices.
