terraform {
  backend "s3" {
    bucket         = "project_name-tf-remote-state-file-uat"
    key            = "global/s3/terraform.tfstate"
    dynamodb_table = "project_name-uat-tf-state-lock"
    region         = "ap-southeast-2"
    encrypt        = true
  }
}




