# cad-terraform-all
# don't push on this repo! It's filled automatically


## Terraform
We use a terraform setup with global state management over AWS S3 Backend.

### Terraform AWS secrets for local testing
add a file with the following content and name "secrets.auto.tfvars"
```sh
access_key = "id"
secret_key = "secret_key"
```
### Terraform Workspaces
ATTENTION: tf_main_setup = "default" workspace

ecr_repos = "ecr_repos" workspace
prod = "prod" workspace (production env)

For all new services for customer, use the uid as workspace name

## Switch between workspaces
```sh
terraform workspaces select <workspace>
```
