resource "aws_s3_bucket" "bucket-backend" {
  bucket = "bucket-for-backend-tf-fastfood-soat"

  tags = {
    Name        = "safe local to save tfstate"
    Environment = "by terraform"
  }
}