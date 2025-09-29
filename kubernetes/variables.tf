variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "rds_endpoint" {
  description = "RDS endpoint"
  type        = string
  default     = "fastfood-soat-db.clm8cegucd6a.sa-east-1.rds.amazonaws.com"
}

variable "prefix"{
  type = string
}