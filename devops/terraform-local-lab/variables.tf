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
