output "aws_command" {
  value = "aws elasticbeanstalk update-environment --application-name ${var.app_name} --version-label ${var.app_version} --environment-name ${var.environment_name}"
}