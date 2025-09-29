variable "region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "prefix"{
  type = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_a" {
  description = "Zona de disponibilidade A"
  type        = string
  default     = "sa-east-1a"
}

variable "az_b" {
  description = "Zona de disponibilidade B"
  type        = string
  default     = "sa-east-1b"
}

variable "public_subnet_a_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  type    = string
  default = "10.0.3.0/24"
}

variable "private_subnet_b_cidr" {
  type    = string
  default = "10.0.4.0/24"
}