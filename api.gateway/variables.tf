variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

# ARNs das Lambdas (auth, middleware)
variable "auth_lambda_arn" {
  type = string
  default = "arn:aws:lambda:sa-east-1:967154861998:function:auth-service"
}

variable "middleware_lambda_arn" {
  type = string
  default = "arn:aws:lambda:sa-east-1:967154861998:function:middleware-service"
}

# ALB/NLB do EKS
variable "eks_alb_arn" {
  type = string
  default = "arn:aws:elasticloadbalancing:sa-east-1:967154861998:loadbalancer/net/k8s-fastfood-fastfood-46ba27f7a0/b88f032db0e7ef2b"
}

variable "eks_alb_dns" {
  type = string
  default = "k8s-fastfood-fastfood-46ba27f7a0-b88f032db0e7ef2b.elb.sa-east-1.amazonaws.com"
}
