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

ecr_repo_adminservice = "ecr_repo_adminservice" workspace
adminservice = "prod-adminservice" workspace

ecr_repo_adminservice = "ecr_repo_adminservice" workspace
ecr_repo_eventservice = "ecr_repo_eventservice" workspace
ecr_repo_scraper = "ecr_repo_scraper" workspace
admin-ui-service = "prod-admin-ui-service" workspace
adminservice = "prod-adminservice" workspace
userservice = "prod-userservice" workspace

## Switch between workspaces
```sh
terraform workspaces select <workspace>
```
