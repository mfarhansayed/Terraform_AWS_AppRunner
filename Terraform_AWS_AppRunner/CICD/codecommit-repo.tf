#----------------- Data Block of existing Repo -----------------------------
data "aws_codecommit_repository" "project_name" {
  repository_name = "project_name"
}

data "aws_codecommit_repository" "project_name-UI" {
  repository_name = "project_name-UI"
}


data "aws_codecommit_repository" "project_name-Infra" {
  repository_name = "project_name-Infra"
}