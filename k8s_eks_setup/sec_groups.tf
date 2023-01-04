# locals {
#     #cl_subnet_ids = [ "subnet-0fc4b0b34837ba485","subnet-0bd6a11fdeb24a3c8","subnet-07c3d749d8eaadd26" ]
#     #cl_subnet_ids = module.vpc.private_subnets
#     #cl_vpc_id = "vpc-0ce0e6a6d4780b78b"
#     #cl_vpc_id = module.vpc.vpc_id
# }


# resource "aws_security_group" "worker_group_one" {
#     name_prefix = "worker_group_one"
#     #vpc_id = module.vpc.vpc_id
#     vpc_id = local.cl_vpc_id
#     ingress {
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = [
#             "0.0.0.0/0"
#         ]
#     }
#     ingress {
#         from_port = 8443
#         to_port = 8443
#         protocol = "tcp"
#         cidr_blocks = [
#             "0.0.0.0/0"
#         ]
#     }
# }