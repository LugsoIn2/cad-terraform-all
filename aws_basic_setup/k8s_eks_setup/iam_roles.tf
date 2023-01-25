resource "aws_iam_role" "eks-to-route53" {
  name = "eks-to-route53"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          #Federated = "${data.aws_eks_cluster.oidc_provider}"
          #Federated = module.eks.oidc_provider_arn
          Federated = "${module.eks.oidc_provider_arn}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
            StringEquals = {
                "${module.eks.oidc_provider}:aud": "sts.amazonaws.com"
            }
        }
      }
    ]
  })
depends_on = [
  module.eks
]
}


resource "aws_iam_role_policy" "eks-to-route53-policy" {
  name = "eks-to-route53-policy"
  role = aws_iam_role.eks-to-route53.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "route53:ChangeResourceRecordSets"
        ],
        Resource = [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        Resource = [
          "*"
        ]

      }

    ]
  })
  depends_on = [
    aws_iam_role.eks-to-route53
  ]
}

resource "aws_iam_role_policy_attachment" "attach-eks-to-route53-managed-pol" {
  role       = aws_iam_role.eks-to-route53.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  depends_on = [
    aws_iam_role.eks-to-route53
  ]
}




