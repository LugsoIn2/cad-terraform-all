# cad-terraform-all 

## Commands for creaton
In the working directories must be a secrets.auto.tfvar with the following content.
Alternativ sind auch Umgebungsvariablen möglich die mit dem Prefix TF_VAR_ erstellt werden. (recommended way for the Adminservice Container).


| Var-Name      | value             |
| ------------- | ----------------- |
| access_key    | aws_key_id        |
| secret_key    | aws_secret_key    |
| gh_token      | GitHub PAC Token  |

Before the infrastructure can be set up, an initalsetup of Terraform must be performed. This includes the state backend of Terraform on Amazon AWS S3 and dynamoDB with the default workspace from Terraform. (in our case it's be done)

This can be done with:
```sh
terraform -chdir=./tf_main_setup
```

Container registry repositories also had to be created in Amazon AWS ECR for the container services. These are automatically populated by the GitHub CI pipeline. 
This can be done after the initalsetup with:
```sh
terraform workspace new ecr_repos
terraform -chdir=./tf_main_setup
```


Following commands are for the infrastructure:
Asumed that the Terraform workspace of the productive environment (free) has already been created. (terraform workspace new prod).
Customer ID's must start with a letter. (k8s dependencie)

**Productive environment**
```sh
terraform -chdir=./prod init
terraform -chdir=./prod workspace select prod
terraform -chdir=./prod apply
```
**Standard customer environment**
```sh
terraform -chdir=./subsc_standard init
terraform -chdir=./subsc_standard workspace new <Customer_ID>
terraform -chdir=./subsc_standard apply
```
**Enterprise customer environment**
```sh
terraform -chdir=./subsc_enterprise init
terraform -chdir=./subsc_enterprise workspace new <Customer_ID>
terraform -chdir=./subsc_enterprise apply
```


## Terraform
We use a terraform setup with global state management over AWS S3 Backend.
### Terraform Workspaces
ATTENTION: tf_main_setup = "default" workspace

ecr_repos = "ecr_repos" workspace
prod = "prod" workspace (production env)

For all new services for customer, use the uid as workspace name

## Switch between workspaces
```sh
terraform workspaces select <workspace>
```
