variable "aws_region" {
  description = "AWS region where the existing EC2 instance lives"
  type        = string
  default     = "ap-south-2"
}

variable "ami_id" {
  description = "AMI ID currently used by your existing EC2 instance"
  type        = string
  default     = "ami-01ffec8d88d72cdd7"
}

variable "instance_type" {
  description = "Current instance type of your existing EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = "lallo"
}

variable "subnet_id" {
  description = "Subnet ID of your existing EC2 instance"
  type        = string
  default     = "subnet-08813b21349421a6e"
}

variable "security_group_ids" {
  description = "Security group IDs attached to your existing EC2 instance"
  type        = list(string)
  default     = ["sg-0af0187fd41b88117"]
}

variable "instance_name" {
  description = "Name tag to keep on the existing EC2 instance"
  type        = string
  default     = "PEP-DevOps-Server"
}
