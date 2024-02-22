#-------------------------- -----DEV -----------------------------------------------------------

#------------------ CODEBUILD PROJECT FOR DEV FRONTEND SERVICE ---------------------------------
resource "aws_codebuild_project" "frontend" {
  count          = var.create_codebuild_dev-frontend-apprunner == true ? 1 : 0
  name           = var.project_names_dev-frontend
  description    = var.dev_frontend_codebuild_description
  build_timeout  = var.build_timeout
  service_role   = aws_iam_role.codebuild-service-role[0].arn
  source_version = var.ref_dev-frontend-apprunner # branch name for dev frontend service

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = var.compute_type
    image           = var.codebuild_image
    type            = var.container_type
    privileged_mode = var.privileged_mode

    environment_variable {
      name  = "ASSUME_ROLE_ARN"
      value = aws_iam_role.codebuildinstancerole[0].arn

    }
  }

  depends_on = [aws_iam_role.codebuildinstancerole]
  source {
    type     = var.source_type
    location = data.aws_codecommit_repository.project_name-UI.id
  }

  tags = {
    Name    = "${var.prefix}-${var.codebuild_fe_tag}"
    project = "project_name"
  }
}

#------------------ CODEBUILD PROJECT FOR DEV BACKEND SERVICE ---------------------------------
resource "aws_codebuild_project" "backend" {
  depends_on     = [aws_iam_role.codebuildinstancerole]
  count          = var.create_codebuild_dev-backend-apprunner == true ? 1 : 0
  name           = var.project_names_dev-backend
  description    = var.dev_backend_codebuild_description
  build_timeout  = var.build_timeout
  service_role   = aws_iam_role.codebuild-service-role[0].arn
  source_version = var.ref_dev-backend-apprunner # branch name for dev backend service 

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = var.compute_type
    image           = var.codebuild_image
    type            = var.container_type
    privileged_mode = var.privileged_mode

    environment_variable {
      name  = "ASSUME_ROLE_ARN"
      value = aws_iam_role.codebuildinstancerole[0].arn
    }
  }

  source {
    type     = var.source_type
    location = data.aws_codecommit_repository.project_name.id
  }

  tags = {
    Name    = "${var.prefix}-${var.codebuild_be_tag}"
    project = "project_name"
  }
}

#-------------------------- UAT-----------------------------------------------------------------

#------------------ CODEBUILD PROJECT FOR UAT FRONTEND SERVICE ---------------------------------
resource "aws_codebuild_project" "frontend_uat" {
  count          = var.create_codebuild_uat-frontend-apprunner == true ? 1 : 0
  name           = var.project_names_uat-frontend
  description    = var.uat_frontend_codebuild_description
  build_timeout  = var.build_timeout
  service_role   = aws_iam_role.codebuild-service-role[0].arn
  source_version = var.ref_uat-frontend-apprunner # branch name for dev frontend service

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = var.compute_type
    image           = var.codebuild_image
    type            = var.container_type
    privileged_mode = var.privileged_mode

    environment_variable {
      name  = "ASSUME_ROLE_ARN"
      value = aws_iam_role.codebuildinstancerole[0].arn
    }
  }

  depends_on = [aws_iam_role.codebuildinstancerole]
  source {
    type      = var.source_type
    location  = data.aws_codecommit_repository.project_name-UI.id
    buildspec = file("${path.module}/templates/buildspec-ui.yml")
  }

  tags = {
    Name    = "${var.prefix}-${var.codebuild_fe_uat_tag}"
    project = "project_name"
  }
}

#------------------ CODEBUILD PROJECT FOR UAT BACKEND SERVICE ---------------------------------
resource "aws_codebuild_project" "backend_uat" {
  depends_on     = [aws_iam_role.codebuildinstancerole]
  count          = var.create_codebuild_uat-backend-apprunner == true ? 1 : 0
  name           = var.project_names_uat-backend
  description    = var.uat_backend_codebuild_description
  build_timeout  = var.build_timeout
  service_role   = aws_iam_role.codebuild-service-role[0].arn
  source_version = var.ref_uat-backend-apprunner # branch name for dev backend service 

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = var.compute_type
    image           = var.codebuild_image
    type            = var.container_type
    privileged_mode = var.privileged_mode

    environment_variable {
      name  = "ASSUME_ROLE_ARN"
      value = aws_iam_role.codebuildinstancerole[0].arn
    }
  }

  source {
    type      = var.source_type
    location  = data.aws_codecommit_repository.project_name.id
    buildspec = file("${path.module}/templates/buildspec-api.yml")
  }

  tags = {
    Name    = "${var.prefix}-${var.codebuild_be_uat_tag}"
    project = "project_name"
  }
}





#------------------ CODEBUILD PROJECT FOR TEST-CASE DEV BACKENDSERVICE ---------------------------------
resource "aws_codebuild_project" "test-backend" {
  depends_on     = [aws_iam_role.codebuildinstancerole]
  count          = var.create_codebuild_dev-test-backend-apprunner == true ? 1 : 0
  name           = var.project_names_dev-test-backend
  description    = var.dev_backend_codebuild_description
  build_timeout  = var.build_timeout
  service_role   = aws_iam_role.codebuild-service-role[0].arn
  source_version = var.ref_dev-test-backend-apprunner # branch name for dev backend service 

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = var.compute_type
    image           = var.codebuild_image
    type            = var.container_type
    privileged_mode = var.privileged_mode

    environment_variable {
      name  = "ASSUME_ROLE_ARN"
      value = "arn:aws:iam::account_id:role/project_name-codebuildinstancerole"
    }

  }

  source {
    type     = var.source_type
    location = data.aws_codecommit_repository.project_name-Infra.id
    #buildspec = file("${path.module}/templates/buildspec.yml")
  }

  tags = {
    Name    = "${var.prefix}-${var.codebuild_be_tag}"
    project = "project_name"
  }
}