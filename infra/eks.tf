module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${var.prefix}-fastfood-eks"
  kubernetes_version = "1.33"
  enable_irsa        = true

  endpoint_public_access                   = true
  enable_cluster_creator_admin_permissions = true

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
    aws-ebs-csi-driver = {}
  }

  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id = data.aws_vpc.fastfood.id
  subnet_ids = concat(
    data.aws_subnets.public.ids,
    data.aws_subnets.private.ids
  )

  tags = {
    Project     = "fastfood"
    Environment = "production"
  }
}