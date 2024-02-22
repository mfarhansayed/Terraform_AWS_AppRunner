
resource "aws_s3_bucket" "terraform_state" {
  bucket = "project_name-terraform-remote-state-file-dev"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    project = "project_name"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true


}


# terraform {
#   backend "s3" {
#     bucket         = "project_name-terraform-remote-state-file-dev"
#     key            = "global/s3/terraform.tfstate"
#     dynamodb_table = "project_name-dev-terraform-state-lock"
#     region         = "ap-southeast-2"
#     encrypt        = true
#   }
# }


resource "aws_dynamodb_table" "terraform_state" {
  name         = "project_name-dev-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


