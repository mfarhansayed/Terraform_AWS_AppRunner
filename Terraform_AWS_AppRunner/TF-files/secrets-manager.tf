#----------------------------- BACKEND SERVICE SECRETS -----------------------------------

resource "aws_secretsmanager_secret" "db_username" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.db_username

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "db_password" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.db_password

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}
resource "aws_secretsmanager_secret" "postgres_uri" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.postgres_uri_secret_name

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "django_sk_secret_name" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.django_sk_secret_name

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "django_hosts_secret_name" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.django_hosts_secret_name

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "cors_whitelist_secret_name" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.cors_whitelist_secret_name

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "aws_storage_bucket_name" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.aws_storage_bucket_name

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "celery_broker_url" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.celery_broker_url
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "email_sender" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.email_sender
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "email_host" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.email_host
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "email_provider" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.email_provider
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "aws_region_be_secrets" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.aws_region_be_secrets
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "google_api_url" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.google_api_url
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "google_api_key" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.google_api_key
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "totp_access_key" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.totp_access_key
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}


resource "aws_secretsmanager_secret" "project_name_api_key" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.project_name_api_key
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "project_name_api_url" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.project_name_api_url
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

#----------------------------- FRONTEND SERVICE SECRETS -----------------------------------

resource "aws_secretsmanager_secret" "react_app_api_endpoint" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.react_app_api_endpoint

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}


resource "aws_secretsmanager_secret" "react_app_api_base_url" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.react_app_api_base_url

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}

resource "aws_secretsmanager_secret" "react_app_auth_base_url" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.react_app_auth_base_url

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}


resource "aws_secretsmanager_secret" "react_app_api_key_location" {
  count = var.create_secretsmanager_secret == true ? 1 : 0
  name  = var.react_app_api_key_location

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.secretsmanager_tag}"
  }
}
