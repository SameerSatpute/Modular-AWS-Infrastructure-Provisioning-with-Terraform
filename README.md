# Modular AWS Infrastructure with Terraform

A Terraform project that provisions an AWS environment from reusable modules (VPC, EC2, IAM, S3, security group). EC2 instances are defined as a map and created with `for_each`, and Terraform state is stored remotely in S3 with native locking.


## What this project does

- Creates a custom VPC with one public and one private subnet in two availability zones.
- The public subnet routes to the internet through an internet gateway.
- The private subnet has no internet route. It reaches S3 through a **gateway VPC endpoint**, so no NAT gateway is needed and traffic stays on the AWS network.
- The private EC2 instance uses an **IAM role and instance profile** to write logs to S3 without hardcoded credentials.
- The S3 logs bucket has versioning, AES-256 encryption, all public access blocked, and a lifecycle rule (transition to Glacier, then expiry).
- EC2 instances are created from a single map variable using for_each, so adding a server means adding one entry.
- Terraform state lives in a versioned, encrypted S3 bucket with native state locking.

## Project structure
── backend/
   └── s3_backend.tf        # one-time bootstrap: creates the state bucket
── modules/
     ── vpc/                 # VPC, subnets, IGW, route table, S3 endpoint
     ── security_group/      # security group, ingress and egress rules
     ── iam/                 # IAM role, policy attachment, instance profile
     ── ec2/                 # key pair and EC2 instances (for_each)
     ── s3/                  # logs bucket with encryption and lifecycle
── main.tf                  # root module wiring everything together
── provider.tf              # AWS provider and S3 backend configuration

## Prerequisites

- Terraform 1.10 or later (needed for use_lockfile)
- AWS CLI configured (aws configure) with permissions for EC2, VPC, S3 and IAM
- AWS provider 6.x (the project pins 6.71.0)
- An SSH key pair:
  Command: ssh-keygen -t rsa -b 4096 -f key-ec2

## Usage
### 1. Create the remote state bucket (once)

cd backend
terraform init
terraform apply
cd ..

### 2. Deploy the infrastructure

Update the values in "main.tf" first: the logs bucket name (must be globally unique), the AMI ID for your region, and the path to your public key.

terraform init
terraform validate
terraform plan
terraform apply

### 3. Destroy
terraform destroy

The logs bucket has versioning enabled, so empty it (including old versions) before destroying. Do not destroy the `backend/` configuration while the main project still uses its bucket.

## Design decisions

- **Gateway endpoint instead of NAT gateway:** the private instance only needs S3. A gateway endpoint is free and limits the instance to S3 only, while a NAT gateway costs money and opens a path to the whole internet.
- **Separate backend configuration:** the state bucket is created in its own folder so it exists before `terraform init` needs it, and so `terraform destroy` on the main project never deletes its own state.
- **IAM role instead of access keys:** instances get S3 access through an instance profile, so no credentials live on the server.
- **`for_each` map for EC2:** one resource block and one variable replace repeated, numbered variables, and each instance is named after its map key.

## Known limitations and planned improvements

This is a learning project, not a production setup.

- SSH (port 22) is open to "0.0.0.0/0" for testing. In production, restrict it to a known IP or use SSM Session Manager.
- The role uses "AmazonS3FullAccess". A policy scoped to the logs bucket and prefix would be better.
- The S3 endpoint is attached to the VPC's main route table. A dedicated private route table is cleaner.
- Both instances share one security group.
- Several values (AMI, bucket name, key path) are set directly in "main.tf". They could move to variables and "terraform.tfvars".

## Security notes

Never commit these files. Make sure ".gitignore" includes:

.terraform/
*.tfstate
*.tfstate.*
key-ec2
*.pem

## Tech stack

Terraform, AWS (VPC, EC2, IAM, S3, VPC Endpoints), Infrastructure as Code
