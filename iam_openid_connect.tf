data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github_oidc_role" {
  name = "GitHubActionsOIDCRole-${data.aws_caller_identity.current.account_id}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        "StringLike" : {
          "token.actions.githubusercontent.com:sub" : "repo:${var.repo_full_name}:ref:refs/heads/main"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "github_oidc_policy" {
  name = "GitHubS3AccessPolicy-${data.aws_caller_identity.current.account_id}"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:ListBucket"],
        Resource = "arn:aws:s3:::my-tfm-state-bucket-july-2025"
      },
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
        Resource = [
          "arn:aws:s3:::my-tfm-state-bucket-july-2025/",
          "arn:aws:s3:::my-tfm-state-bucket-july-2025/*"
        ]
      },
      {
        Effect   = "Allow",
        Action   = ["iam:GetOpenIDConnectProvider"],
        Resource = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
      },
      {
        Effect = "Allow",
        Action = [
          "iam:GetRole",
          "iam:ListRolePolicies",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:ListAttachedRolePolicies"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeImages",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeRouteTables",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroupRules"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "allow_ec2_actions" {
  name        = "AllowEC2Actions"
  description = "Allow necessary EC2 actions for Terraform operations"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVolumes",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeTags",
          "ec2:CreateTags",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:RebootInstances",
          "ec2:AllocateAddress",
          "ec2:AssociateAddress",
          "ec2:DescribeInstanceAttribute",
          "ec2:ModifyInstanceAttribute",
          "ec2:DescribeInstanceCreditSpecifications",
          "ec2:ImportKeyPair"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "import_key_pair_policy" {
  name        = "ImportKeyPairPolicy-${data.aws_caller_identity.current.account_id}"
  description = "Allow ImportKeyPair operation on EC2"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "ec2:ImportKeyPair"
        Resource = "arn:aws:ec2:ap-south-1:${data.aws_caller_identity.current.account_id}:key-pair/my-ec2key"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_import_key_pair_policy" {
  policy_arn = aws_iam_policy.import_key_pair_policy.arn
  role       = aws_iam_role.github_oidc_role.name
}

resource "aws_iam_role_policy_attachment" "github_attach_policy" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = aws_iam_policy.github_oidc_policy.arn
}


resource "aws_iam_role_policy_attachment" "attach_ec2_policy" {
  policy_arn = aws_iam_policy.allow_ec2_actions.arn
  role       = aws_iam_role.github_oidc_role.name
}