output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.fastfood-vpc.id
}

output "public_subnets_ids" {
  description = "IDs das subnets públicas"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnets_ids" {
  description = "IDs das subnets privadas"
  value       = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "eks_cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  description = "Nome do cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_id" {
  description = "ID do cluster EKS"
  value       = module.eks.cluster_id
}

output "eks_cluster_arn" {
  description = "ARN do cluster EKS"
  value       = module.eks.cluster_arn
}