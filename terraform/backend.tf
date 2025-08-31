terraform {
  backend "s3" {
    bucket         = "terraform-bucket-ayushi-redis-tool"   # Replace with your S3 bucket name
    key            = "terraform/terraform.tfstate"      # Path within the bucket
    region         = "ap-south-1"               # Replace with your AWS region
    encrypt        = true
    
  }
}
