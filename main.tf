
# Core Components Built
# Custom VPC (10.0.0.0/16): An isolated network instead of using the Default VPC.

# Public Subnet (10.0.1.0/24): Connected to an Internet Gateway so the web server can accept public traffic.

# Security Group: A virtual firewall restricting inbound traffic strictly to HTTP (80) and SSH (22), while allowing all outbound traffic.

# EC2 Instance (t2.micro or t3.micro): A Linux virtual machine bootstrapped with a user_data script that automatically installs and starts an Nginx web server.

# IAM Role & Instance Profile: Grants the EC2 instance read-only access to an S3 bucket without embedding hardcoded AWS credentials in the code.

# 1. Instantiate Networking Module
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  environment        = var.environment
}

# 2. Instantiate Security Module (Passes VPC ID from Networking Module)
module "security" {
  source      = "./modules/security"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

# 3. Instantiate Compute Module (Passes Subnet & SG IDs from preceding modules)
module "compute" {
  source            = "./modules/compute"
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security.web_security_group_id
  instance_type     = var.instance_type
  environment       = var.environment
}

# # Testing the Pipeline - Adding a new resource - S3 Bucket
# resource "aws_s3_bucket" "pipeline_test_bucket" {
#   bucket_prefix = "cicd-test-bucket-"

#   tags = {
#     ManagedBy = "Terraform-CodePipeline"
#   }
# }