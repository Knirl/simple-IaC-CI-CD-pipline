






variable "subnet_id" {
  type        = string
  description = "Subnet ID to deploy the instance into"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID to attach to the instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance size"
}

variable "environment" {
  type        = string
  description = "Environment name"
}