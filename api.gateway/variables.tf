variable "aws-region" {
  type    = string
}

# ARNs das Lambdas (auth, middleware)
variable "auth-lambda-arn" {
  type = string
}

variable "middleware-lambda-arn" {
  type = string
}

# ALB/NLB do EKS
variable "eks-alb-arn" {
  type = string
}

variable "eks-alb-dns" {
  type = string
}

# Prefixo para nomes dos recursos
variable "prefix" {
  type = string
}
