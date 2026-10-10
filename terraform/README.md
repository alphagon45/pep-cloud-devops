# PEP Cloud and DevOps — Terraform

This Terraform starter is intended to import and manage the **existing** EC2 instance instead of creating a duplicate.

## Prerequisites

- Terraform CLI installed on Windows
- AWS CLI installed and configured with credentials for the correct AWS account
- IAM permissions to describe and manage EC2
- Confirmed existing instance ID and matching settings

Never put AWS access keys, private SSH keys, or tokens in this repository.

## 1. Open this folder in PowerShell

```powershell
cd "$HOME\pep-cloud-devops\terraform"
```

Copy these Terraform files into that folder first. If your repository does not have a `terraform` folder, create one.

## 2. Verify AWS credentials and region

```powershell
aws sts get-caller-identity
aws configure get region
aws ec2 describe-instances --region ap-south-2 --instance-ids i-0927696b2f75fd054 --query "Reservations[0].Instances[0].{State:State.Name,AMI:ImageId,Type:InstanceType,Key:KeyName,Subnet:SubnetId,SecurityGroups:SecurityGroups[*].GroupId,PublicIP:PublicIpAddress}" --output table
```

Make sure the account is the intended account and compare the returned settings with `variables.tf`. Update defaults if AWS reports different values.

## 3. Initialize and validate

```powershell
terraform init
terraform fmt
terraform validate
```

## 4. Import the existing EC2 instance into Terraform state

Only do this if this Terraform directory has not already imported this instance and its state is not already managed elsewhere:

```powershell
terraform import aws_instance.app i-0927696b2f75fd054
```

Terraform state can contain infrastructure metadata. Keep it private and do not commit state files to GitHub.

## 5. Review the plan — do not apply blindly

```powershell
terraform plan
```

Review every proposed change. If Terraform proposes to replace/destroy the EC2 instance, or unexpectedly change its network settings, **stop** and do not run `terraform apply`. Share the plan output with a helper after redacting account IDs, public IPs, and other sensitive details as desired.

The `prevent_destroy` lifecycle rule is an extra safeguard against accidental destruction, but it does not make every possible change safe.

## 6. Outputs

After import and a clean plan, run:

```powershell
terraform output
```

This project intentionally does not create a new VPC, subnet, security group, or EC2 instance. It manages the existing instance resource only; the network resources remain managed outside this Terraform configuration.
