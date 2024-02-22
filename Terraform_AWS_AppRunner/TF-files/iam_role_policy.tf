#------------------ APP RUNNER BUILD ROLE POLICY ---------------------------------

resource "aws_iam_role_policy" "ecr_policy" {
  count = var.create_ecr_policy == true ? 1 : 0
  name  = var.ecr_policy_name
  role  = aws_iam_role.app_runner_build_role[0].id

  # Permissions to pull images from ECR
  policy = file("${path.module}/${var.env}/ecr_policy.json")

}


#------------------ APP RUNNER INSTANCE ROLE SECRET MANAGER & SSM POLICY ---------------------------------

resource "aws_iam_role_policy" "secret_manager-ssm_policy" {
  count = var.create_secret_manager-ssm_policy == true ? 1 : 0
  name  = var.secret_manager-ssm_policy_name
  role  = aws_iam_role.app_runner_instance_role[0].id

  policy = file("${path.module}/${var.env}/secret_manager-ssm_policy.json")

}

#------------------ APP RUNNER INSTANCE ROLE S3 POLICY ---------------------------------

resource "aws_iam_role_policy" "s3_access_policy" {
  count = var.create_s3_access_policy == true ? 1 : 0
  name  = var.s3_access_policy_name
  role  = aws_iam_role.app_runner_instance_role[0].id

  policy = file("${path.module}/${var.env}/s3_access_policy.json")

}

#--------------- SES -------------------------
resource "aws_iam_role_policy" "ses_access_policy" {
  count = var.create_ses_access_policy == true ? 1 : 0
  name  = var.ses_access-policy_name
  role  = aws_iam_role.app_runner_instance_role[0].id

  policy = file("${path.module}/${var.env}/ses_access_policy.json")

}

#--------------- SQS -------------------------
resource "aws_iam_role_policy" "sqs_access_policy" {
  count = var.create_sqs_access_policy == true ? 1 : 0
  name  = var.sqs_access_policy_name
  role  = aws_iam_role.app_runner_instance_role[0].id

  policy = file("${path.module}/${var.env}/sqs_access_policy.json")

}


