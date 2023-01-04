# cad-terraform-all 

## Terraform
We use a terraform setup with global state management over AWS S3 Backend.

## Initial Setup
In the working directories must be a secrets.auto.tfvar with the following content.
Alternatively, environment variables can be created with the prefix TF_VAR_. (recommended for the Adminservice Container).


| TF_VAR_ Prefix    | Var-Name              | value                         |
| ----------------- | --------------------- | ----------------------------- |
|         x         | access_key            | aws_key_id                    |
|         x         | secret_key            | aws_secret_key                |
|         x         | gh_token              | GitHub PAC Token              |
|                   | AWS_ACCESS_KEY_ID     | aws_key_id_for_tfbackend      |
|                   | AWS_SECRET_ACCESS_KEY | aws_secret_key_for_tfbackend  |


### Terrafrom Backend S3 (tf_main_setup) (DONE_FOR_US)
Before the infrastructure can be set up, an initalsetup of Terraform must be performed. This includes the state backend of Terraform on Amazon AWS S3 and dynamoDB with the default workspace from Terraform.

This can be done with:
```
terraform apply -chdir=./tf_main_setup
```
Info: For the first creation you must comment out the S3 backend Provider block. After this creaton you can uncomment the block and migrate from local state file to S3.

### Container Registry Repositories (tf_ecr_repos) (DONE_FOR_US)
Container registry repositories also had to be created in Amazon AWS ECR for the container services. These are automatically populated by the GitHub CI pipeline.
This can be done after the initalsetup with:
```
terraform workspace new ecr_repos
terraform apply -chdir=./tf_ecr_repos
```

### Setup AWS Elastic Kubernetes Cluster (k8s_eks_setup)
This setup creates a new AWS EKS cluster and deploys an nginx ingress controller on the cluster, preceded by an AWS Network Load Balancer. It also deploys an externel-dns service on the cluster that synchronizes the Kubernetes internal DNS records to the external AWS Route53 DNS service for a specific hostet Zone (aws.netpy.de).

**INFO**
For cost reasons please destroy after developing or testing. For a AWS clean destroy please make sure you had destroyed all applied services with another Script before you destroy the cluster. 

**Apply**
```
terraform workspace new eks_cluster
terraform apply -chdir=./k8s_eks_setup
```
Info: if the workspace exists use the workspace select command.

**Destroy**
```
terraform destroy -chdir=./k8s_eks_setup
```

### Commands for the Environments

Following commands are for the infrastructure:
Asumed that the Terraform workspace of the productive environment (free) has already been created. (terraform workspace new prod). **(in our case it's be done)**
Customer ID's must start with a letter. (k8s dependencie)

**Productive environment**
```
terraform -chdir=./prod init
terraform -chdir=./prod workspace select prod
terraform -chdir=./prod apply
```
**Standard customer environment**
```
terraform -chdir=./subsc_standard init
terraform -chdir=./subsc_standard workspace new <Customer_ID>
terraform -chdir=./subsc_standard apply
```
**Enterprise customer environment**
```
terraform -chdir=./subsc_enterprise init
terraform -chdir=./subsc_enterprise workspace new <Customer_ID>
terraform -chdir=./subsc_enterprise apply
```

## Service Domain names 
Domain names are automatically created for all services. 
For customer here are TF_workspacename = Customer_ID

| Service           | Domain name                                        |
| ----------------- | -------------------------------------------------- |
| userservice       | <TF_workspacename>-userservice.aws.netpy.de        |
| eventservice      | <TF_workspacename>-eventservice.aws.netpy.de       |
| admin-ui-service  | <TF_workspacename>-admin-ui-service.aws.netpy.de   |
| adminservice      | <TF_workspacename>-adminservice.aws.netpy.de       |

## Switch between workspaces
```
terraform workspaces select <workspace>
```
