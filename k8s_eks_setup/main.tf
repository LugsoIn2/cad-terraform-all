locals {
    cl_subnet_ids = [ "subnet-0fc4b0b34837ba485","subnet-0bd6a11fdeb24a3c8","subnet-07c3d749d8eaadd26" ]
    cl_vpc_id = "vpc-0ce0e6a6d4780b78b"
    cluster_name = "CAD-Event"
}

data "aws_availability_zones" "azs" {
    state = "available"
}

data "aws_availability_zones" "available" {}


module "eks"{
    source = "terraform-aws-modules/eks/aws"
    version = "18.30.3"
    cluster_name = local.cluster_name
    cluster_version = "1.24"
    #subnet_ids = module.vpc.private_subnets
    subnet_ids = local.cl_subnet_ids
    tags = {
        Name = "CAD-Event"
    }
    #vpc_id = module.vpc.vpc_id
    vpc_id = local.cl_vpc_id

    eks_managed_node_groups = {
        eks-cl-group1 = {
            max_size     = 1
            min_size     = 1
            desired_size = 1
            instance_types = ["t3.large"] #for free use t2.micro, t3.medium=17Pods t3.large=35 Pods
            #additional_security_group_ids = [aws_security_group.worker_group_one.id]

            tags = {
                "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
                #"kubernetes.io/cluster/${local.cluster_name}" = "owned"
                "k8s.io/cluster-autoscaler/enabled" = true
            }
        }
    }

    node_security_group_additional_rules = {
        ingress_nodes_karpenter_port = {
            description                   = "Cluster API to Node group for Karpenter webhook"
            protocol                      = "tcp"
            from_port                     = 8443
            to_port                       = 8443
            type                          = "ingress"
            source_cluster_security_group = true
        }
    }

    manage_aws_auth_configmap = true
    aws_auth_users = var.map_aws_eks_auth_iam_users
}


output "test1234" {
    value = module.eks.node_security_group_arn
}

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}