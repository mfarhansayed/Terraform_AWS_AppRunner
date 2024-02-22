#-------------------- VPC CONNECTOR --------------------------------------------------
resource "aws_apprunner_vpc_connector" "connector" {
  count              = var.create_vpc_connect == true ? 1 : 0
  vpc_connector_name = var.vpc_connector_name
  subnets            = [aws_subnet.subnet[1].id, aws_subnet.subnet[3].id]
  security_groups    = [aws_security_group.vpc_connector-sg[0].id]

  tags = {
    Name    = "${var.prefix}-${var.vpc_connector_tag}"
    project = "project_name"
  }
}

# -------------------------- APP RUNNER VPC ENDPOINT INGRESS CONNECTION ----------------------

resource "aws_apprunner_vpc_ingress_connection" "example" {
  count       = var.create_apprunner-backend_service == true ? 1 : 0
  name        = var.apprunner_vpc_ingress_connection_name
  service_arn = aws_apprunner_service.backend_service[0].arn
  ingress_vpc_configuration {
    vpc_id          = aws_vpc.myvpc[0].id
    vpc_endpoint_id = aws_vpc_endpoint.apprunner[0].id
  }
}

#------------------- APP RUNNER BACKEND SERVICE ---------------------------------------
resource "aws_apprunner_service" "backend_service" {
  count        = var.create_apprunner-backend_service == true ? 1 : 0
  service_name = var.aws_apprunner_service_name

  source_configuration {
    image_repository {
      image_configuration {
        port = var.port_no_be
        runtime_environment_secrets = {
          POSTGRES_URI            = data.aws_secretsmanager_secret_version.postgres_uri.arn
          DJANGO_SECURITY_KEY     = data.aws_secretsmanager_secret_version.django_sk.arn
          DJANGO_ALLOWED_HOSTS    = data.aws_secretsmanager_secret_version.django_hosts.arn
          CORS_WHITELIST          = data.aws_secretsmanager_secret_version.cors_whitelist.arn
          AWS_STORAGE_BUCKET_NAME = data.aws_secretsmanager_secret_version.aws_storage_bucket_name.arn
          CELERY_BROKER_URL       = data.aws_secretsmanager_secret_version.celery_broker_url.arn
          EMAIL_HOST              = data.aws_secretsmanager_secret_version.email_host.arn
          EMAIL_PROVIDER          = data.aws_secretsmanager_secret_version.email_provider.arn
          EMAIL_SENDER            = data.aws_secretsmanager_secret_version.email_sender.arn
          AWS_REGION              = data.aws_secretsmanager_secret_version.aws_region_be_secrets.arn
          GOOGLE_API_URL          = data.aws_secretsmanager_secret_version.google_api_url.arn
          GOOGLE_API_KEY          = data.aws_secretsmanager_secret_version.google_api_key.arn
          TOTP_ACCESS_KEY         = data.aws_secretsmanager_secret_version.totp_access_key.arn
          project_name_API_KEY         = data.aws_secretsmanager_secret_version.project_name_api_key.arn
          project_name_API_URL         = data.aws_secretsmanager_secret_version.project_name_api_url.arn
        }
        start_command = var.start_command_be
      }

      image_identifier      = "${aws_ecr_repository.backend_repo[0].repository_url}:${var.image_tag_be}"
      image_repository_type = var.image_repository_type


    }
    auto_deployments_enabled = var.auto_deployments_enabled_value
    authentication_configuration {
      access_role_arn = aws_iam_role.app_runner_build_role[0].arn # <----
    }

  }

  health_check_configuration {
    healthy_threshold   = 3
    interval            = 5
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }

  network_configuration {
    ingress_configuration {
      is_publicly_accessible = var.publicly_accessible_be
    }
    egress_configuration {
      egress_type       = var.egress_type_be
      vpc_connector_arn = aws_apprunner_vpc_connector.connector[0].arn
    }
  }

  instance_configuration {
    cpu               = var.instance_configuration_cpu
    memory            = var.instance_configuration_memory
    instance_role_arn = aws_iam_role.app_runner_instance_role[0].arn # <------------
  }

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.backend_tag}"
  }
}


#----------------- Data block-------------------------

data "aws_secretsmanager_secret_version" "postgres_uri" {
  secret_id = "/project_name/portal/postgres_uri"
}

data "aws_secretsmanager_secret_version" "django_sk" {
  secret_id = "/project_name/portal/django_security_key"
}

data "aws_secretsmanager_secret_version" "django_hosts" {
  secret_id = "/project_name/portal/django_allowed_hosts"
}

data "aws_secretsmanager_secret_version" "cors_whitelist" {
  secret_id = "/project_name/portal/cors_whitelist"
}

data "aws_secretsmanager_secret_version" "aws_storage_bucket_name" {
  secret_id = "/project_name/portal/aws_storage_bucket_name"
}

data "aws_secretsmanager_secret_version" "celery_broker_url" {
  secret_id = "/project_name/portal/celery_broker_url"
}
data "aws_secretsmanager_secret_version" "email_sender" {
  secret_id = "/project_name/portal/email_sender"
}
data "aws_secretsmanager_secret_version" "email_host" {
  secret_id = "/project_name/portal/email_host"
}
data "aws_secretsmanager_secret_version" "email_provider" {
  secret_id = "/project_name/portal/email_provider"
}

data "aws_secretsmanager_secret_version" "aws_region_be_secrets" {
  secret_id = "/project_name/portal/aws_region"
}

data "aws_secretsmanager_secret_version" "google_api_url" {
  secret_id = "/project_name/portal/google_api_url"
}

data "aws_secretsmanager_secret_version" "google_api_key" {
  secret_id = "/project_name/portal/google_api_key"
}

data "aws_secretsmanager_secret_version" "totp_access_key" {
  secret_id = "/project_name/portal/totp_access_key"
}

data "aws_secretsmanager_secret_version" "project_name_api_key" {
  secret_id = "/project_name/portal/project_name_api_key"
}


data "aws_secretsmanager_secret_version" "project_name_api_url" {
  secret_id = "/project_name/portal/project_name_api_url"
}
