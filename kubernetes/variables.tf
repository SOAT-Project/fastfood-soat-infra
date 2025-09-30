# Database
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
  description = "RDS endpoint for the database"
  type        = string
}

# Application
variable "application_port" {
  description = "Port where the application will run"
  type        = string
  default     = "8080"
}

variable "auth_token_expiration" {
  description = "Auth token expiration in seconds"
  type        = string
  default     = "43200"
}

# Mercado Pago
variable "mp_token" {
  description = "Mercado Pago token"
  type        = string
  sensitive   = true
}

variable "collector_id" {
  description = "Mercado Pago collector ID"
  type        = string
}

variable "pos_id" {
  description = "POS identifier"
  type        = string
}

variable "mp_base_url" {
  description = "Mercado Pago API base URL"
  type        = string
  default     = "https://api.mercadopago.com"
}

variable "prefix"{
  type = string
}