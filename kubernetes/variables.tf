variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "meu_usuario_test"
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
  default     = "minha_senha_teste"
}

variable "rds_endpoint" {
  description = "RDS endpoint"
  type        = string
  default     = "fastfood-soat-db.c9wcvz6wenbw.sa-east-1.rds.amazonaws.com"
}