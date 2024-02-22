#---------------- ECR FOR BACKEND SERVICE -------------------------------------
resource "aws_ecr_repository" "backend_repo" {
  count                = var.create_ecr_be == true ? 1 : 0
  name                 = var.backend_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = var.force_delete_value
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.ecr_name_be}"
  }
}

resource "aws_ecr_repository_policy" "ecr-policy" {
  repository = aws_ecr_repository.backend_repo[0].name
  policy     = data.aws_iam_policy_document.ecrpolicy.json
}


#-------------------- ECR FOR FRONTEND SERVICE ---------------------------------------

resource "aws_ecr_repository" "frontend_repo" {
  count                = var.create_ecr_fe == true ? 1 : 0
  name                 = var.frontend_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = var.force_delete_value

  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.ecr_name_fe}"
  }
}

resource "aws_ecr_repository_policy" "fe-ecr-policy" {
  repository = aws_ecr_repository.frontend_repo[0].name
  policy     = data.aws_iam_policy_document.ecrpolicy.json
}

#--------------Datablock-----------------------------------------
data "aws_iam_policy_document" "ecrpolicy" {

  statement {
    sid    = "AllowPushPull"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::account_id:root"]
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
  }
}
