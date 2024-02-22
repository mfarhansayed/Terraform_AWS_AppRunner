terraform {
    source = "../../TF-files/"

}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
    provider "aws" {
    region = "ap-southeast-2"
    
}
EOF

}


inputs = {
env = "templates-dev"




#------------ REGION ------------------------
region = "ap-southeast-2"

# ------------ RESOURCE PREFIX ------------------------
prefix = "project_name"

#------------ VPC -------------------------------
create_vpc           = true
enable_dns_support   = true
enable_dns_hostnames = true
vpc_cidr             = "CIDR-RANGE"
vpc_name             = "VPC"

#----------------------- SECURITY GROUP -------------------------------------------
create_security_group = true
vpc_sg_name           = "vpc-sg"  
default_security_group_ingress_rules = [
    {
      description = "TLS from VPC"
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 8000
      to_port     = 8000
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    }
  ]

  default_security_group_egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

vpc_connector_sg_name = "vpc_connector_sg"

vpc_connector-sg_ingress_rules = [
    {
      description = "TLS from VPC"
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 433
      to_port     = 433
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 8000
      to_port     = 8000
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 5432
      to_port     = 5432
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    }
    
  ]

vpc_connector-sg_egress_rules = [
  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

]
vpc_endpoint_sg_name  = "vpc_endpoint_sg"
vpc_endpoint-sg_ingress_rules =[

  {
      description = "TLS from VPC"
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
      description = "TLS from VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 8000
      to_port     = 8000
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    }
  ]

  vpc_endpoint-sg_egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

rds_postgres_ingress_rules = [
    {
      description = "TLS from VPC"
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
      description = "TLS from VPC"
      from_port   = 5432
      to_port     = 5432
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE","10.255.209.192/32"]
    },
    {
      description = "TLS from VPC"
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    },
    {
    description = "TLS from VPC"
 
      from_port   = 8000
      to_port     = 8000
      protocol    = "TCP"
      cidr_blocks = ["CIDR-RANGE"]
    }
  ]


  rds_postgres__egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }


  ]



#----------------- SUBNETS ------------------------
create_subnets = true

subnets = {
  "subnet-1" = { cidr_block = "CIDR-RANGE", availability_zone = "ap-southeast-2a", tag_name = "public-subnet-2a" }  #0
  "subnet-2" = { cidr_block = "CIDR-RANGE", availability_zone = "ap-southeast-2a", tag_name = "private-subnet-2a" } #1
  "subnet-3" = { cidr_block = "CIDR-RANGE", availability_zone = "ap-southeast-2b", tag_name = "public-subnet-2b" }  #2
  "subnet-4" = { cidr_block = "CIDR-RANGE", availability_zone = "ap-southeast-2b", tag_name = "private-subnet-2b" } #3
}
#----------------- IG ------------------------------
create_internet_gateway = true
ig_name                 = "internet_gateway"

#----------------- ROUTE TABLE  ------------------------------
create_route_table = true
route-table        = ["Public-RT", "Private-RT"]


#--------------- Elastic IP for the NAT Gateway -----------------------
create_eip       = true
elasticip        = "elastic-ip"
nat-gateway_name = "nat-gateway"

#---------------------- VPC ENDPOINT ----------------------------------
create_vpc_endpoint       = true
vpc_endpoint_service_name = "com.amazonaws.ap-southeast-2.apprunner.requests"
vpc_endpoint_type         = "Interface"
vpc_endpoint_name         = "vpc_endpoint"

# ------------------ ECR --------------------------------

create_ecr_be      = true
create_ecr_fe      = true
backend_repo_name  = "project_name-api"
frontend_repo_name = "project_name-ui"
force_delete_value = false
ecr_name_be        = "backend-service"
ecr_name_fe        = "frontend-service"

# ------------------- PostgreSQL ---------------------------------------------------
create_postgresdbpvt               = true
postgresdbpvt_sq_name              = "private_subnet_group"
create_rds_postgres_security_group = true
postgresrdsname                    = "project_name"
postgresengine                     = "postgres"
postgresrdsversion                 = "15.4"
instance_class_postgres           = "db.m5.xlarge"
postgresstoragetype               = "gp2"
allocated_storage_postgres        = "100"
multi_az_postgres                 = false
publicly_accessible_postgrespvt   = false
retionperiod_postgres             = 30
delete_automated_backups_postgres = false
copy_tags_to_snapshot_postgres    = true
deletion_protection_postgres      = true
skip_final_snapshot_postgres      = false
rds_postgres_security_group_name  = "PostgreSQL_Security-group"
private_subnet_group              = "private_subnet_group"
postgres-final-snapshot           = "postgres-final-snapshot"

#---------------- SECRET MANAGER --------------------------------

create_secretsmanager_secret = true
db_username                  = "/project_name/portal/db_username"
db_password                  = "/project_name/portal/db_password"
postgres_uri_secret_name     = "/project_name/portal/postgres_uri"
django_sk_secret_name        = "/project_name/portal/django_security_key"
django_hosts_secret_name     = "/project_name/portal/django_allowed_hosts"
cors_whitelist_secret_name   = "/project_name/portal/cors_whitelist"
aws_storage_bucket_name      = "/project_name/portal/aws_storage_bucket_name"
celery_broker_url            = "/project_name/portal/celery_broker_url"
email_sender                 = "/project_name/portal/email_sender"
email_host                   = "/project_name/portal/email_host"
email_provider               = "/project_name/portal/email_provider"
aws_region_be_secrets        = "/project_name/portal/aws_region"
google_api_url               = "/project_name/portal/google_api_url"
google_api_key               = "/project_name/portal/google_api_key"
totp_access_key              = "/project_name/portal/totp_access_key"
project_name_api_key              = "/project_name/portal/project_name_api_key"
project_name_api_url              = "/project_name/portal/project_name_api_url"
email_host_user              = "/project_name/portal/email_host_user"
email_host_password          = "/project_name/portal/email_host_password"

secretsmanager_tag = "secretsmanager"

react_app_api_endpoint     = "/project_name/portal/react_app_api_endpoint"
react_app_api_base_url     = "/project_name/portal/react_app_api_base_url"
react_app_auth_base_url    = "/project_name/portal/react_app_auth_base_url"
react_app_api_key_location = "/project_name/portal/react_app_api_key_location"


#------------------ SES --------------------------------


create_ses_email_identity = true
ses_email                 = "noreply@project_name.com"

create_ses_domain_identity = true
sending_domain             = "project_name.com"

#-----------------SQS------------------------------------------------

create_sqs_queue = true
sqs_queue_name   = "project_nameQueue"

#---------------- APPRUNNER BUILD & INSTANCE ROLE & POLICY--------------------------------
create_app_runner_build_role     = true
app_runner_build_role_name       = "apprunner-build-role"
create_app_runner_instance_role  = true
app_runner_instance_role_name    = "app_runner_instance_role"
create_ecr_policy                = true
ecr_policy_name                  = "ecr_pull_policy"
create_secret_manager-ssm_policy = true
secret_manager-ssm_policy_name   = "secret_manager-ssm_policy"
create_s3_access_policy          = true
project_name-portal-bucket-name       = "project_name-portal-dev"
s3_access_policy_name            = "s3_access_policy"
create_ses_access_policy         = true
ses_access-policy_name           = "ses_access_policy"
create_sqs_access_policy         = true
sqs_access_policy_name           = "sqs_access_policy"
#---------------- APPRUNNER VPC CONNECT & Endpoint --------------------------------

create_vpc_connect                    = true
create_vpc_ingress_connection         = true
vpc_connector_name                    = "vpc-connector"
vpc_connector_tag                     = "vpc-connector"
apprunner_vpc_ingress_connection_name = "vpc-endpoint"


#---------------- BACKEND APPRUNNER --------------------------------
create_apprunner-backend_service = true
aws_apprunner_service_name       = "project_name-api"
port_no_be                       = "80"
start_command_be                 = "./run-uwsgi.sh"
image_repository_type            = "ECR"
image_tag_be                     = "latest"
auto_deployments_enabled_value   = true
instance_configuration_cpu       = 4096
instance_configuration_memory    = "12 GB"
publicly_accessible_be           = false
egress_type_be                   = "VPC"
backend_tag                      = "backend"

#---------------- FRONTEND APPRUNNER --------------------------------

create_apprunner-frontend-service = true
aws_apprunner_service_name_fe     = "project_name-ui"
port_no_fe                        = "80"
start_command_fe                  = "/app/run-nginx.sh"
image_repository_type_fe          = "ECR"
auto_deployments_enabled_value_fe = true
instance_configuration_cpu_fe     = 4096
instance_configuration_memory_fe  = "12 GB"
image_tag_fe                      = "latest"
publicly_accessible_fe            = true
egress_type_fe                    = "VPC"
frontend_tag                      = "frontend-service"

#-------------------- CUSTOM DOMAIN -----------------------
custom_domain = "dev-portal.project_name.com"

}

