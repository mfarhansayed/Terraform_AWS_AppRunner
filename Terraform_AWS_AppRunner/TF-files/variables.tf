#------------ REGION ------------------------
variable "region" {
  default = "ap-southeast-2"
}


#------------ ENVIRONMENT ---------------------
variable "env" {
  type = string
  default = "dev"
}

#------------ VPC -------------------------------
variable "create_vpc" {
  type    = bool
  default = true
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}
variable "vpc_cidr" {
  type        = string
  description = "CIDR Value of the VPC"
  default     = "10.0.0.0/16"
}
variable "prefix" {
  description = "Prefix to use all the provisioned resources 1.0.4"
  type        = string
  default     = "project_name"
}

variable "vpc_name" {
  type    = string
  default = "Dev-VPC"
}

#----------------------- SECURITY GROUP -------------------------------------------

#---------------- DEFAULT SG------------------------------------------------
variable "create_security_group" {

  type    = bool
  default = true

  description = "Whether to create create_security_group or not"

}

variable "vpc_sg_name" {
  type    = string
  default = "vpc-sg"
}

variable "default_security_group_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
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
}
  
variable "default_security_group_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

#--------------------- VPC CONNECTOR SG ---------------------------------------------------------
variable "vpc_connector_sg_name" {
  type    = string
  default = "vpc_connector_sg"
}

variable "vpc_connector-sg_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
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
}
   
variable "vpc_connector-sg_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

#----------------VPC ENDPOINT SG---------------------------------------
variable "vpc_endpoint_sg_name" {
  type    = string
  default = "vpc_endpoint_sg"
}

variable "vpc_endpoint-sg_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
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
}
 
  
variable "vpc_endpoint-sg_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

#----------------- SUBNETS ------------------------

variable "create_subnets" {
  type    = bool
  default = true

}

variable "subnets" {
  description = "Map of subnets with their configurations"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tag_name          = string
  }))
}

#----------------- IG ------------------------------

variable "create_internet_gateway" {
  type    = bool
  default = true

}

variable "ig_name" {
  type    = string
  default = "internet_gateway"
}


#----------------- ROUTE TABLE  ------------------------------

variable "create_route_table" {
  type    = bool
  default = true

}

variable "route-table" {

  type    = list(string)
  default = ["Public-Web-RT", "Private-AZ1-RT", "Private-AZ2-RT"]

}

#--------------- Elastic IP for the NAT Gateway -----------------------
variable "create_eip" {
  type    = bool
  default = true

}

variable "elasticip" {
  type    = string
  default = "elastic-ip1"
}

variable "nat-gateway_name" {
  type    = string
  default = "nat-gateway1"
}

#---------------------- VPC ENDPOINT ----------------------------------

variable "create_vpc_endpoint" {
  type    = bool
  default = true

}

variable "vpc_endpoint_service_name" {
  default = "com.amazonaws.us-west-2.apprunner.requests"

}

variable "vpc_endpoint_type" {
  default = "Interface"

}
variable "vpc_endpoint_name" {
  type    = string
  default = "dev-vpc_endpoint"
}

# ------------------ ECR --------------------------------
variable "create_ecr_be" {
  type    = bool
  default = true

}
variable "create_ecr_fe" {
  type    = bool
  default = true

}

variable "backend_repo_name" {
  type    = string
  default = "dev-backend"
}

variable "frontend_repo_name" {
  type    = string
  default = "dev-frontend"
}

variable "force_delete_value" {
  type    = bool
  default = true
}
variable "ecr_name_be" {
  type    = string
  default = "backend-service"
}

variable "ecr_name_fe" {
  type    = string
  default = "frontend-service"
}


# ------------------- PostgreSQL ---------------------------------------------------
variable "create_postgresdbpvt" {
  type    = bool
  default = false

}

variable "postgresdbpvt_sq_name" {
  type    = string
  default = "private_subnet_group"
}

variable "create_rds_postgres_security_group" {

  type    = bool
  default = false

}

variable "postgresrdsname" {
  default = "postgresrdsdb"
}

variable "postgresengine" {
  default = "postgres"
}

variable "postgresrdsversion" {
  default = "15.4"
}

// Username for the administrator DB user.
variable "postgres_admin_username" {
  default = "postgres_admin_username"
}

// Password for the administrator DB user.
variable "postgres_admin_password" {
  default = "Postgresadminpassword123"
}

// The instance type of the RDS instance.
variable "instance_class_postgres" {
  default = "db.t3.medium"
}

variable "postgresstoragetype" {
  default = "gp2"

}

// The allocated storage in gigabytes.
variable "allocated_storage_postgres" {
  default = "50"
}

// Specifies if the RDS instance is multi-AZ.
variable "multi_az_postgres" {
  default = "true"
}

variable "publicly_accessible_postgrespvt" {
  default = false
}

variable "retionperiod_postgres" {
  default = 7
}

variable "delete_automated_backups_postgres" {
  default = true
}

variable "copy_tags_to_snapshot_postgres" {
  default = false
}

variable "deletion_protection_postgres" {
  default = false
}

// Determines whether a final DB snapshot is created before the DB instance is deleted.
variable "skip_final_snapshot_postgres" {
  type    = string
  default = false
}

variable "postgres-final-snapshot" {

  type    = string
  default = "postgres-final-snapshot"
}
#-------------------- POSTGRESQL DB SG -----------------------------------
variable "rds_postgres_security_group_name" {
  type    = string
  default = "PostgreSQL_Security-group"
}

variable "rds_postgres_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
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
}
   
variable "rds_postgres__egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


variable "private_subnet_group" {

  type    = string
  default = "private_subnet_group"

}

#---------------- APPRUNNER BUILD & INSTANCE ROLE & POLICY--------------------------------

variable "create_app_runner_build_role" {
  type    = bool
  default = true

}

variable "app_runner_build_role_name" {

  type    = string
  default = "app_runner_build_role"

}

variable "create_app_runner_instance_role" {
  type    = bool
  default = true

}

variable "app_runner_instance_role_name" {

  type    = string
  default = "app_runner_instance_role"

}

variable "create_ecr_policy" {
  type    = bool
  default = true

}

variable "ecr_policy_name" {

  type    = string
  default = "ecr_pull_policy"

}


variable "create_secret_manager-ssm_policy" {
  type    = bool
  default = true

}

variable "secret_manager-ssm_policy_name" {

  type    = string
  default = "secret_manager-ssm_policy"

}

variable "create_s3_access_policy" {
  type    = bool
  default = true

}

variable "project_name-portal-bucket-name" {
   type    = string
  default  = "project_name-portal-dev"
}

variable "s3_access_policy_name" {

  type    = string
  default = "s3_access_policy"

}

variable "create_ses_access_policy" {
  type    = bool
  default = true

}

variable "ses_access-policy_name" {

  type    = string
  default = "ses_access_policy"

}

variable "create_sqs_access_policy" {
  type    = bool
  default = true

}

variable "sqs_access_policy_name" {

  type    = string
  default = "sqs_access_policy"

}

#---------------- APPRUNNER VPC CONNECT & Endpoint --------------------------------
variable "create_vpc_connect" {
  type    = bool
  default = true

}
variable "create_vpc_ingress_connection" {
  type    = bool
  default = true

}

variable "vpc_connector_name" {
  type    = string
  default = "dev-vpc-connector"

}
variable "vpc_connector_tag" {
  type    = string
  default = "dev-vpc-connector"

}

variable "apprunner_vpc_ingress_connection_name" {
  type    = string
  default = "dev-vpc-endpoint"

}

#---------------- SECRET MANAGER --------------------------------
variable "create_secretsmanager_secret" {
  type    = bool
  default = true
}

variable "db_username" {
  type    = string
  default = "apprunner-secret"

}

variable "db_password" {
  type    = string
  default = "apprunner-secret"

}

variable "postgres_uri_secret_name" {
  type    = string
  default = "apprunner-secret"

}

variable "django_sk_secret_name" {
  type    = string
  default = "apprunner-secret"

}

variable "django_hosts_secret_name" {
  type    = string
  default = "apprunner-secret"

}

variable "cors_whitelist_secret_name" {
  type    = string
  default = "apprunner-secret"

}

variable "cors_origin_whitelist_secret_name" {
  type    = string
  default = "apprunner-secret"

}

variable "aws_storage_bucket_name" {
  type    = string
  default = "s3_bucket_apprunner"

}


variable "secretsmanager_tag" {
  type    = string
  default = "secretsmanager"

}

variable "react_app_api_endpoint" {
  type    = string
  default = "secretsmanager"

}

variable "react_app_api_base_url" {
  type    = string
  default = "secretsmanager"

}

variable "react_app_auth_base_url" {
  type    = string
  default = "secretsmanager"

}

variable "react_app_api_key_location" {
  type    = string
  default = "secretsmanager"

}

variable "celery_broker_url" {
  type    = string
  default = "secretsmanager"

}

variable "email_sender" {
  type    = string
  default = "secretsmanager"

}

variable "email_host" {
  type    = string
  default = "secretsmanager"

}

variable "email_provider" {
  type    = string
  default = "secretsmanager"

}

variable "aws_region_be_secrets" {
  type    = string
  default = "secretsmanager"

}

variable "google_api_url" {
  type    = string
  default = "secretsmanager"

}

variable "google_api_key" {
  type    = string
  default = "secretsmanager"

}

variable "totp_access_key" {
  type    = string
  default = "secretsmanager"

}

variable "project_name_api_key" {
  type    = string
  default = "secretsmanager"

}

variable "project_name_api_url" {
  type    = string
  default = "secretsmanager"

}

#-----------------------------------------
variable "email_host_user" {
  type    = string
  default = "secretsmanager"

}

variable "email_host_password" {
  type    = string
  default = "secretsmanager"

}

#---------------- SSM --------------------------------

variable "create_ssm_parameter" {
  type    = bool
  default = true
}

variable "ssm_tag" {
  type    = string
  default = "parameter_store"

}

#------------------ SES --------------------------------


variable "create_ses_email_identity" {
  type    = bool
  default = true
}

variable "ses_email" {
  type    = string
  default = "noreply@project_name.com"

}

variable "create_ses_domain_identity" {
  type    = bool
  default = true
}

variable "sending_domain" {
  type    = string
  default = "project_name.com"

}
#-----------------SQS----------------------------------
variable "create_sqs_queue" {
  type    = bool
  default = true
}

variable "sqs_queue_name" {
  type    = string
  default = "project_nameQueue"

}

#---------------- BACKEND APPRUNNER --------------------------------

variable "create_apprunner-backend_service" {
  type    = bool
  default = true

}

variable "aws_apprunner_service_name" {
  type    = string
  default = "backend-service"

}

variable "port_no_be" {
  type    = string
  default = "8080"

}

variable "start_command_be" {
  type    = string
  default = "python runapp.py"

}


variable "runtime_environment_variables_be" {
  type        = map(string)
  description = "Environment variables available to your running App Runner service."
  default = {
    KEY1 = "VALUE1"
  }
}


variable "image_repository_type" {
  type    = string
  default = "ECR"
}

variable "image_tag_be" {
  type = string
}


variable "auto_deployments_enabled_value" {
  type    = bool
  default = true

}
variable "instance_configuration_cpu" {
  type    = string
  default = "1024"

}
variable "instance_configuration_memory" {
  type    = string
  default = "2 GB"

}
variable "publicly_accessible_be" {
  type    = bool
  default = false

}
variable "egress_type_be" {
  type    = string
  default = "VPC"

}
variable "backend_tag" {
  type    = string
  default = "backend-service"

}

#---------------- FRONTEND APPRUNNER --------------------------------

variable "create_apprunner-frontend-service" {
  type    = bool
  default = true

}
variable "aws_apprunner_service_name_fe" {
  type    = string
  default = "Frontend-service"

}
variable "port_no_fe" {
  type    = string
  default = "8080"
}

variable "start_command_fe" {
  type    = string
  default = "python runapp.py"

}


variable "runtime_environment_variables_fe" {
  type        = map(string)
  description = "Environment variables available to your running App Runner service."
  default = {
    KEY1 = "VALUE1"
  }
}
variable "image_repository_type_fe" {
  type    = string
  default = "ECR"

}

variable "image_tag_fe" {
  type = string
}

variable "auto_deployments_enabled_value_fe" {
  type    = bool
  default = true

}
variable "instance_configuration_cpu_fe" {
  type    = string
  default = "1024"

}
variable "instance_configuration_memory_fe" {
  type    = string
  default = "2 GB"

}

variable "publicly_accessible_fe" {
  type    = bool
  default = true

}
variable "egress_type_fe" {
  type    = string
  default = "VPC"

}
variable "frontend_tag" {
  type    = string
  default = "frontend-service"
}

#------------------ CUSTOM DOMAIN -----------------------
variable "custom_domain" {
  type    = string
  default = "project_name.com"
}



