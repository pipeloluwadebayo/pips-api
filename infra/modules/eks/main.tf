module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 3
      min_size     = 2
      instance_types = ["t3.large"]
      capacity_type  = "ON_DEMAND"
    }
  }

  enable_irsa = true

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  tags = { 
    Project = var.cluster_name }
}