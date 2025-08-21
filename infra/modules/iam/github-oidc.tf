# OIDC Provider for GitHub Actions
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

# IAM role for GitHub Actions deployments
resource "aws_iam_role" "github_oidc_deploy" {
  name = "github-oidc-deploy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:my-org/my-repo:*"
          }
        }
      }
    ]
  })
}

# ECR access
resource "aws_iam_role_policy_attachment" "github_ecr" {
  role       = aws_iam_role.github_oidc_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# EKS access 
resource "aws_iam_role_policy_attachment" "github_eks" {
  role       = aws_iam_role.github_oidc_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "github_eks_worker" {
  role       = aws_iam_role.github_oidc_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
