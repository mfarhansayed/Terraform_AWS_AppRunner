# APP RUNNER-Infra-Automation

 
This repository uses terraform-terragrunt to automate infrastructure provisioning in project_name AWS account.

## DEVOPS Deployment Architecture
![DevOps Deployment Architecture](https://github.com/mfarhansayed/Terraform_AWS_AppRunner/assets/84790596/f1412525-4451-4253-8d2a-f07f67ccb197)


## DEVOPS WORKFLOW
### INFRA PROVISIONING USING TERRAFORM
-	Provision the necessary infrastructure resources, including Network Layer, Database Layer, ECR, S3, Secrets Manager, SES, SQS, DynamoDB and AppRunner for both the Frontend and Backend services.

-	Setup the environments configs.

-	 `backend.tf` - includes the configuration for storing the backend in remote-state & state locking using i.e S3 Bucket.

- `terragrunt.hcl` - The terragrunt.hcl file is a Terragrunt-specific configuration file used to assign values to variables defined in the project. it allows users to set values for variables, such as AWS region, instance types, or any other configurable parameters. By maintaining a separate terragrunt.hcl file, users can easily update or modify variable values without altering the main Terraform configuration files.


-	After configuring the settings, apply Terraform to provision all the necessary resources.
## How To Use
 

**Setup the Environment:**
 

Use Installation guides given below to install dependencies based upon your operating system.
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

- [ AWS CLI ](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


### Clone the repository
  - Clone the code from the repository
  ```sh
  git clone https://github.com/mfarhansayed/Terraform_AWS_AppRunner.git
  ```
  - Configuring the aws credentials for project_name-dev account by using the following command
  ```sh
  aws configure
  ```
- provide access & secret key of account and region is to be selected


## To make changes in Infra-resources.
- Open `terragrunt.hcl` file in the environments folder and click on required folder.
 
1. In `terragrunt.hcl` under terragrunt.hcl navigate to specific resource in inputs section that has resource name labelled above it.
 
2. Under `terragrunt.hcl` - All the resources are variablized & creation of resource can be controlled using `inputs block`
 
3. `terragrunt init` - terragrunt init initializes the Terragrunt configuration, downloads the specified Terraform configurations, and sets up the backend for remote state management.
 
4. `terragrunt plan` - terragrunt plan generates and displays an execution plan based on the Terraform configurations, allowing you to review the changes that will be applied before actually applying them.
 
5.  ` terragrunt apply -auto-approve` - to apply the changes

6. Add , commit and push the latest changes

 ```sh
git add .
git commit -m "message"
git push origin master
---

## HOW TO CHECK AUTOMATIC DEPLOYMENT IN APP RUNNER?

### Steps  to verify that your latest push to master is actually deployed to App Runner
1. Check the Status of the Pipeline , status of the pipeline should reflect status as Succedded, if status of  pipeline shows Failed check the buildspec logs.
 
2. In AppRunner to check the changes committed  check the deployment logs Event Started and Ended time in **Start Deployment** section.
 
- NOTE: The Image deployed will be tagged with the latest tag - To verify this navigate to respective AppRunner service and in the **Services Overview** Source should have the ECR image with the latest tag.
 
3. If you want to track the commit-id of the deployed image you can verify it in the ECR Image with the commit-id,latest . example given below
`` v0.1.0-7545bd5,latest ``

## To make changes in AppRunner-Configurations for updating the image tag
  
- Navigate to the below file path

1. In `terragrunt.hcl` navigate  to FRONTEND APPRUNNER/ BACKEND APPRUNNER section

2. Under `image_tag_be` for BACKEND APPRUNNER and `image_tag_fe` for FRONTEND APPRUNNER change the Image tag to the latest pushed image value that is available at the project_name-api / project_name-ui ECR repo
 
3. `terragrunt plan` - to verify the changes
 
4.  ` terragrunt apply -auto-approve` - to apply the changes

- Add , commit and push the latest changes

 ```sh
git add .
git commit -m "message"
git push origin master
 ```
