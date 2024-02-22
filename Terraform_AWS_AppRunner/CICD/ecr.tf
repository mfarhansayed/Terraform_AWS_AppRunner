
resource "aws_ecr_repository" "node-18" {
  count                = var.create_image_repo == true ? 1 : 0
  name                 = var.node-18
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = var.force_delete_value
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.ecr_imag_name}"
  }
}

resource "aws_ecr_repository" "ubuntu" {
  count                = var.create_image_repo == true ? 1 : 0
  name                 = var.ubuntu
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = var.force_delete_value
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.ecr_imag_name}"
  }
}

resource "aws_ecr_repository" "nginx-stable-alpine" {
  count                = var.create_image_repo == true ? 1 : 0
  name                 = var.nginx-stable-alpine
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = var.force_delete_value
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.ecr_imag_name}"
  }
}


