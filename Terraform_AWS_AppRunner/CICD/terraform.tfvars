#------------ REGION ------------------------
region = "ap-south-1"

# ------------ RESOURCE PREFIX ------------------------
prefix = "project_name"

#----------------------- ECR --------------------------
create_image_repo   = true
force_delete_value  = true
ecr_imag_name       = "docker-images"
node-18             = "project_name/node"
ubuntu              = "project_name/ubuntu"
nginx-stable-alpine = "project_name/nginx"

#----------------------- COMMAN CODEBUILD PROJECT SETTINGS ----------------------------------
build_timeout   = "15"
compute_type    = "BUILD_GENERAL1_SMALL"
codebuild_image = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
container_type  = "LINUX_CONTAINER"
privileged_mode = true
source_type     = "CODECOMMIT"

#------------------ CODEBUILD PROJECT SERVICE ROLE -------------------------------------------
create_codebuild-service-role       = true
project_name-codebuild-service-role_name = "project_name-codebuild-service-role"
project_name-codebuildinstancerole_name  = "project_name-codebuildinstancerole"
#------------------ CODEBUILD PROJECT FOR DEV BACKEND SERVICE ---------------------------------

create_codebuild_dev-backend-apprunner     = true
project_names_dev-backend                  = "project_name-api-project"
ref_dev-backend-apprunner                  = "refs/heads/master"
project_name-codebuild-service-role-policy_name = "project_name-codebuild-service-role-policy"
project_name-codebuildinstance-role-policy_name = "project_name-codebuildinstance-role-policy"
codebuild_be_tag                           = "dev-backend-project"

#------------------ CODEBUILD PROJECT FOR DEV FRONTEND SERVICE ---------------------------------

create_codebuild_dev-frontend-apprunner = true
project_names_dev-frontend              = "project_name-ui-project"
ref_dev-frontend-apprunner              = "refs/heads/master"
codebuild_fe_tag                        = "dev-frontend-project"

#------------------------ UAT----------------------------------------------------------------------

#------------------ CODEBUILD PROJECT FOR UAT BACKEND SERVICE ---------------------------------

create_codebuild_uat-backend-apprunner = true
project_names_uat-backend              = "project_name-api-uat-project"
ref_uat-backend-apprunner              = "refs/heads/master"
codebuild_be_uat_tag                   = "dev-backend-project"

#------------------ CODEBUILD PROJECT FOR UAT FRONTEND SERVICE ---------------------------------

create_codebuild_uat-frontend-apprunner = true
project_names_uat-frontend              = "project_name-ui-uat-project"
ref_uat-frontend-apprunner              = "refs/heads/master"
codebuild_fe_uat_tag                    = "dev-frontend-project"


#----------------------------TEST-CASE DEV BACKENDSERVICE ----------------------------------------------
create_codebuild_dev-test-backend-apprunner = true
project_names_dev-test-backend              = "project_name-dev-test-backend"
ref_dev-test-backend-apprunner              = "refs/heads/migrate-run"


#---------------- CODEPIPELINE SERVICE ROLE & POLICY--------------------------------
create_codepipeline_role              = true
project_name-codepipelin_service_role_name = "project_name-codepipelin_service_role"
create_codepipeline_role_policy       = true
project_name-codepipeline_role_policy_name = "project_name-codepipeline_role_policy"
# ----------------------CODEPIPELINE BACKEND ---------------------------------------------------
create_codepipeline_be    = true
create_s3_codepipeline_be = true
codepipeline_be_name      = "project_name-api-pipeline"
artifact_store_type_be    = "S3"
encryption_key_be         = "KMS"
repo_name_be              = "project_name"
branch_be                 = "master"
cp_bucket_be              = "project_name-dev-backend-pipeline-s3-bucket"
s3kmskey_be               = "alias/aws/s3"
force_destroy_s3          = true
# ----------------------CODEPIPELINE FRONTEND  ---------------------------------------------------
create_codepipeline_fe    = true
create_s3_codepipeline_fe = true
codepipeline_fe_name      = "project_name-ui-pipeline"
artifact_store_type_fe    = "S3"
encryption_key_fe         = "KMS"
repo_name_fe              = "project_name-UI"
branch_fe                 = "master"
cp_bucket_fe              = "project_name-dev-frontend-pipeline-s3-bucket"
s3kmskey_fe               = "alias/aws/s3"

#--------------------------- UAT--------------------------------------------------------------------

# ----------------------CODEPIPELINE BACKEND ---------------------------------------------------
create_codepipeline_be_uat    = true
create_s3_codepipeline_be_uat = true
codepipeline_be_uat_name      = "project_name-api-uat-pipeline"
artifact_store_type_be_uat    = "S3"
encryption_key_be_uat         = "KMS"
repo_name_be_uat              = "project_name"
branch_be_uat                 = "master"
cp_bucket_be_uat              = "project_name-uat-backend-pipeline-s3-bucket"
s3kmskey_be_uat               = "alias/aws/s3"
force_destroy_s3_uat          = true

# ----------------------CODEPIPELINE FRONTEND  ---------------------------------------------------
create_codepipeline_fe_uat    = true
create_s3_codepipeline_fe_uat = true
codepipeline_fe_uat_name      = "project_name-ui-uat-pipeline"
artifact_store_type_fe_uat    = "S3"
encryption_key_fe_uat         = "KMS"
repo_name_fe_uat              = "project_name-UI"
branch_fe_uat                 = "master"
cp_bucket_fe_uat              = "project_name-uat-frontend-pipeline-s3-bucket"
s3kmskey_fe_uat               = "alias/aws/s3"