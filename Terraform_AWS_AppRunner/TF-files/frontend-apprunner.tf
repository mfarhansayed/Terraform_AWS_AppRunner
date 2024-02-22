resource "aws_apprunner_service" "frontend-service" {
  count        = var.create_apprunner-frontend-service == true ? 1 : 0
  service_name = var.aws_apprunner_service_name_fe

  source_configuration {
    image_repository {
      image_configuration {
        port = var.port_no_fe
        runtime_environment_secrets = {
          REACT_APP_API_ENDPOINT     = data.aws_secretsmanager_secret_version.react_app_api_endpoint.arn
          REACT_APP_API_BASE_URL     = data.aws_secretsmanager_secret_version.react_app_api_base_url.arn
          REACT_APP_AUTH_BASE_URL    = data.aws_secretsmanager_secret_version.react_app_auth_base_url.arn
          REACT_APP_API_KEY_LOCATION = data.aws_secretsmanager_secret_version.react_app_api_key_location.arn

        }
        start_command = var.start_command_fe
      }
      image_identifier      = "${aws_ecr_repository.frontend_repo[0].repository_url}:${var.image_tag_fe}"
      image_repository_type = var.image_repository_type_fe
    }
    auto_deployments_enabled = var.auto_deployments_enabled_value_fe
    authentication_configuration {
      access_role_arn = aws_iam_role.app_runner_build_role[0].arn
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
      is_publicly_accessible = var.publicly_accessible_fe
    }
    egress_configuration {
      egress_type       = var.egress_type_fe
      vpc_connector_arn = aws_apprunner_vpc_connector.connector[0].arn
    }
  }

  instance_configuration {
    cpu               = var.instance_configuration_cpu_fe
    memory            = var.instance_configuration_memory_fe
    instance_role_arn = aws_iam_role.app_runner_instance_role[0].arn
  }
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.frontend_tag}"
  }
}

#----------------- Custom Domain Name---------------------------
resource "aws_apprunner_custom_domain_association" "dev-portal" {
  domain_name = var.custom_domain
  service_arn = aws_apprunner_service.frontend-service[0].arn
}
#----------------- Data block-------------------------

data "aws_secretsmanager_secret_version" "react_app_api_endpoint" {
  secret_id = "/project_name/portal/react_app_api_endpoint"
}


data "aws_secretsmanager_secret_version" "react_app_api_base_url" {
  secret_id = "/project_name/portal/react_app_api_base_url"
}

data "aws_secretsmanager_secret_version" "react_app_auth_base_url" {
  secret_id = "/project_name/portal/react_app_auth_base_url"
}

data "aws_secretsmanager_secret_version" "react_app_api_key_location" {
  secret_id = "/project_name/portal/react_app_api_key_location"
}