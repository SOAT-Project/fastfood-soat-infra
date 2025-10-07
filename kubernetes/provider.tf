# Provider AWS (necessário para os data sources)
provider "aws" {
  region = "sa-east-1"
}

data "aws_eks_cluster" "fastfood" {
  name = "${var.prefix}-fastfood-eks"
}

data "aws_eks_cluster_auth" "fastfood" {
  name = "${var.prefix}-fastfood-eks"
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.fastfood.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.fastfood.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.fastfood.token
}