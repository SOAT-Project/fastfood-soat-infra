module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                                     = "fastfood-eks"
  kubernetes_version                       = "1.33"
  enable_cluster_creator_admin_permissions = true

  vpc_id     = aws_vpc.fastfood-vpc.id
  subnet_ids = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  endpoint_public_access  = true   # Habilitar público
  endpoint_private_access = true   # Manter privado também

  eks_managed_node_groups = {
    node_fastfood = {
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 5
      desired_size   = 1
    }
  }

  tags = {
    Project     = "fastfood"
    Environment = "production"
  }
}