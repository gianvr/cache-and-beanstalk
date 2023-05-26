variable "redis_endpoint" {
    type = string
    default = null
}

variable "bucket_id" {
  type = string
  default = null
}

variable "bucket_object_id" {
  type = string
  default = null
}

variable "environment_name" {
  type = string
  default = "beanstalk-environment"
}
  
variable "app_name" {
  type = string
  default = "app-beanstalk"
}

variable "app_version" {
  type = string
  default = "v1"
}

variable "app_version_description" {
  type = string
  default = "Flask application"
}