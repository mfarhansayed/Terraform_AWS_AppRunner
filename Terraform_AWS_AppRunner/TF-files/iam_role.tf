#------------------ APP RUNNER BUILD ROLE ---------------------------------

resource "aws_iam_role" "app_runner_build_role" {
  count = var.create_app_runner_build_role == true ? 1 : 0
  name  = var.app_runner_build_role_name

  assume_role_policy = file("${path.module}/${var.env}/app_runner_build_role-policy.json")

  tags = {
    project = "project_name"
  }
}



#------------------ APP RUNNER INSTANCE ROLE ---------------------------------
resource "aws_iam_role" "app_runner_instance_role" {
  count = var.create_app_runner_instance_role == true ? 1 : 0
  name  = var.app_runner_instance_role_name

  assume_role_policy = file("${path.module}/${var.env}/app_runner_instance_role-policy.json")

  tags = {
    project = "project_name"
  }
}


