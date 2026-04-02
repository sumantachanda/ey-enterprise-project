# S3 Bucket for Terraform State
resource "aws_s3_bucket" "terraform_state" {
  provider = aws.us_east_1
  bucket = "${var.project_name}-tf-state-${random_id.id.hex}"
  
  # Prevent accidental deletion
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  provider = aws.us_east_1
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  provider     = aws.us_east_1
  name         = "${var.project_name}-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "random_id" "id" {
  byte_length = 4
}

# ECR Repository (The Private Vault)
resource "aws_ecr_repository" "app_repo" {
  name                 = "ey-enterprise-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# IAM Role for Jenkins (The Passport Type)
resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach ECR PowerUser policy (The Permission)
resource "aws_iam_role_policy_attachment" "jenkins_ecr_attach" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# Instance Profile (The Badge Jenkins will wear)
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.jenkins_role.name
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "jenkins" {
  source               = "./modules/jenkins"
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id
  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name
}

module "eks" {
  source     = "./modules/eks"
  subnet_ids = module.vpc.public_subnet_ids
}
