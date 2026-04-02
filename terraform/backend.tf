terraform {
  backend "s3" {
    bucket         = "ey-enterprise-tf-state-8715b5c9" # Your unique bucket
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ey-enterprise-tf-locks"
    encrypt        = true
  }
}
