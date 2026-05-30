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
  upper   = false
  lower   = true
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
