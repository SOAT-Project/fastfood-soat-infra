terraform {
  backend "s3" {
    bucket = "bucket-for-backend-tf-fastfood-soat"
    key    = "dev/terraform/terraform.tfstate"
    region = "sa-east-1"
  }
}
