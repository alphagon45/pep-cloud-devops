terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# This configuration is designed to IMPORT your existing EC2 instance.
# It does not create a new instance. Import the instance before running plan.
resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  tags = {
    Name      = var.instance_name
    Project   = "PEP-Cloud-DevOps"
    ManagedBy = "Terraform"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [user_data]
  }
}

output "instance_id" {
  description = "ID of the EC2 instance managed by Terraform"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "Current public IPv4 address of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.app.public_dns
}
