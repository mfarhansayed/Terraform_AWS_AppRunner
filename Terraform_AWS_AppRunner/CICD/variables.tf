#------------ REGION ------------------------
variable "region" {
  default = "us-west-1"
}
# ------------ RESOURCE PREFIX ------------------------
variable "prefix" {
  default = "project_name"
}

#----------------------- ECR --------------------------

variable "create_image_repo" {
  type    = bool
  default = true
}

variable "force_delete_value" {
  type    = bool
  default = true
}

variable "ecr_imag_name" {
  type    = string
  default = "docker-images"
}

variable "node-18" {
  type    = string
  default = "docker-images"
}
variable "ubuntu" {
  type    = string
  default = "docker-images"
}
variable "nginx-stable-alpine" {
  type    = string
  default = "docker-images"
}

#---------------------- CODEBUILD PROJECT ----------------------------------

variable "build_timeout" {
  type    = string
  default = "5"
}

variable "compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_image" {
  type    = string
  default = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
}

variable "container_type" {
  type    = string
  default = "LINUX_CONTAINER"

}

variable "privileged_mode" {
  type    = bool
  default = true
}

variable "source_type" {
  type    = string
  default = "CODECOMMIT"
}

#------------------ CODEBUILD PROJECT FOR DEV FRONTEND SERVICE ---------------------------------
variable "create_codebuild_dev-frontend-apprunner" {
  type    = bool
  default = true
}

variable "project_names_dev-frontend" {
  type    = string
  default = "dev-frontend-project"
}

variable "ref_dev-frontend-apprunner" {
  type    = string
  default = "refs/heads/dev-frontend-apprunner"
}

variable "codebuild_fe_tag" {
  type    = string
  default = "dev-frontend-project"
}

#------------------ CODEBUILD PROJECT SERVICE ROLE -------------------------------------------
variable "create_codebuild-service-role" {
  type    = bool
  default = true
}
variable "project_name-codebuild-service-role_name" {
  type    = string
  default = "project_name-codebuild-service-role"
}
variable "project_name-codebuildinstancerole_name" {
  type    = string
  default = "project_name-codebuildinstancerole"
}

#------------------ CODEBUILD PROJECT FOR DEV BACKEND SERVICE ---------------------------------
variable "create_codebuild_dev-backend-apprunner" {
  type    = bool
  default = true
}

variable "project_name-codebuild-service-role-policy_name" {
  type    = string
  default = "project_name-codebuild-service-role-policy"
}

variable "project_name-codebuildinstance-role-policy_name" {
  type    = string
  default = "project_name-codebuildinstance-role-policy"
}

variable "dev_backend_codebuild_description" {
  type    = string
  default = "CodeBuild project for Dev Backend Service"
}

variable "dev_frontend_codebuild_description" {
  type    = string
  default = "CodeBuild project for Dev Frontend Service"
}

variable "project_names_dev-backend" {
  type    = string
  default = "dev-backend-project"
}
variable "ref_dev-backend-apprunner" {
  type    = string
  default = "refs/heads/dev-backend-apprunner"
}

variable "codebuild_be_tag" {
  type    = string
  default = "dev-backend-project"
}

#------------------- UAT ----------------------------------------------------------------------------

#------------------ CODEBUILD PROJECT FOR UAT FRONTEND SERVICE ---------------------------------
variable "create_codebuild_uat-frontend-apprunner" {
  type    = bool
  default = true
}

variable "project_names_uat-frontend" {
  type    = string
  default = "dev-frontend-project"
}

variable "uat_frontend_codebuild_description" {
  type    = string
  default = "CodeBuild project for Dev Backend Service"
}
variable "ref_uat-frontend-apprunner" {
  type    = string
  default = "refs/heads/dev-frontend-apprunner"
}

variable "codebuild_fe_uat_tag" {
  type    = string
  default = "uat-frontend-project"
}

#------------------ CODEBUILD PROJECT FOR UAT BACKEND SERVICE ---------------------------------
variable "create_codebuild_uat-backend-apprunner" {
  type    = bool
  default = true
}

variable "uat_backend_codebuild_description" {
  type    = string
  default = "CodeBuild project for Dev Backend Service"
}

variable "project_names_uat-backend" {
  type    = string
  default = "dev-backend-project"
}
variable "ref_uat-backend-apprunner" {
  type    = string
  default = "refs/heads/dev-backend-apprunner"
}

variable "codebuild_be_uat_tag" {
  type    = string
  default = "dev-backend-project"
}

#----------------------------TEST-CASE DEV BACKENDSERVICE ----------------------------------------------

variable "create_codebuild_dev-test-backend-apprunner" {
  type    = bool
  default = true

}
variable "project_names_dev-test-backend" {
  type    = string
  default = "dev-test-backend"
}
variable "ref_dev-test-backend-apprunner" {
  type    = string
  default = "refs/heads/devops-test-case"
}


#---------------- CODEPIPELINE SERVICE ROLE & POLICY--------------------------------
variable "create_codepipeline_role" {
  type    = bool
  default = true

}
variable "project_name-codepipelin_service_role_name" {
  type    = string
  default = "project_name-codepipelin_service_role"
}

variable "create_codepipeline_role_policy" {
  type    = bool
  default = true

}

variable "project_name-codepipeline_role_policy_name" {
  type    = string
  default = "project_name-codepipeline_role_policy"
}

# ----------------------CODEPIPELINE BACKEND ---------------------------------------------------
variable "create_codepipeline_be" {
  type    = bool
  default = true
}
variable "create_s3_codepipeline_be" {
  type    = bool
  default = true
}
variable "codepipeline_be_name" {
  type    = string
  default = "dev-backend-pipeline"
}
variable "artifact_store_type_be" {
  type    = string
  default = "S3"
}
variable "encryption_key_be" {
  type    = string
  default = "KMS"
}
variable "repo_name_be" {
  type    = string
  default = "project_name"
}
variable "branch_be" {
  type    = string
  default = "dev-backend-apprunner"
}
variable "cp_bucket_be" {
  type    = string
  default = "dev-backend-pipelinebucket-21112023"
}
variable "force_destroy_s3" {
  type    = bool
  default = true
}
variable "s3kmskey_be" {
  type    = string
  default = "alias/aws/s3"
}

#-------------------------cp test-case------------------------------------
variable "create_codepipeline_be-test" {
  type    = bool
  default = true
}
variable "codepipeline_be-test_name" {
  type    = string
  default = "project_name-devops-test-case"
}
variable "repo_name_be_test" {
  type    = string
  default = "project_name-Infra"
}
variable "branch_be-test" {
  type    = string
  default = "migrate-run"
}
variable "create_s3_codepipeline_be-test" {
  type    = bool
  default = true
}
variable "cp_bucket_be-test" {
  type    = string
  default = "project_name-dev-backend-test-pipelinebucket-21112023"
}
variable "s3kmskey_be-test" {
  type    = string
  default = "alias/aws/s3"
}
# ----------------------CODEPIPELINE FRONTEND  ---------------------------------------------------
variable "create_codepipeline_fe" {
  type    = bool
  default = true
}
variable "create_s3_codepipeline_fe" {
  type    = bool
  default = true
}

variable "codepipeline_fe_name" {
  type    = string
  default = "dev-frontend-pipeline"
}
variable "artifact_store_type_fe" {
  type    = string
  default = "S3"
}
variable "encryption_key_fe" {
  type    = string
  default = "KMS"
}
variable "repo_name_fe" {
  type    = string
  default = "project_name"
}
variable "branch_fe" {
  type    = string
  default = "dev-frontend-apprunner"
}
variable "cp_bucket_fe" {
  type    = string
  default = "dev-frontend-pipelinebucket-21112023"
}
variable "s3kmskey_fe" {
  type    = string
  default = "alias/aws/s3"
}

#------------------------------ UAT---------------------------------------------------------

# ----------------------CODEPIPELINE BACKEND ---------------------------------------------------
variable "create_codepipeline_be_uat" {
  type    = bool
  default = true
}
variable "create_s3_codepipeline_be_uat" {
  type    = bool
  default = true
}
variable "codepipeline_be_uat_name" {
  type    = string
  default = "dev-backend-pipeline"
}
variable "artifact_store_type_be_uat" {
  type    = string
  default = "S3"
}
variable "encryption_key_be_uat" {
  type    = string
  default = "KMS"
}
variable "repo_name_be_uat" {
  type    = string
  default = "project_name"
}
variable "branch_be_uat" {
  type    = string
  default = "dev-backend-apprunner"
}
variable "cp_bucket_be_uat" {
  type    = string
  default = "dev-backend-pipelinebucket-21112023"
}
variable "force_destroy_s3_uat" {
  type    = bool
  default = true
}
variable "s3kmskey_be_uat" {
  type    = string
  default = "alias/aws/s3"
}

# ----------------------CODEPIPELINE FRONTEND  ---------------------------------------------------
variable "create_codepipeline_fe_uat" {
  type    = bool
  default = true
}
variable "create_s3_codepipeline_fe_uat" {
  type    = bool
  default = true
}

variable "codepipeline_fe_uat_name" {
  type    = string
  default = "dev-frontend-pipeline"
}
variable "artifact_store_type_fe_uat" {
  type    = string
  default = "S3"
}
variable "encryption_key_fe_uat" {
  type    = string
  default = "KMS"
}
variable "repo_name_fe_uat" {
  type    = string
  default = "project_name"
}
variable "branch_fe_uat" {
  type    = string
  default = "dev-frontend-apprunner"
}
variable "cp_bucket_fe_uat" {
  type    = string
  default = "dev-frontend-pipelinebucket-21112023"
}
variable "s3kmskey_fe_uat" {
  type    = string
  default = "alias/aws/s3"
}