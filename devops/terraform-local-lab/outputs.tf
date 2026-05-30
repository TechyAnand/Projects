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
