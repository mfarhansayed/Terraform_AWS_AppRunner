terraform {
  backend "s3" {
    bucket         = "project_name-tf-remote-state-file-dev"
    key            = "global/s3/terraform.tfstate"
    dynamodb_table = "project_name-dev-tf-state-lock"
    region         = "ap-southeast-2"
    encrypt        = true
  }
}