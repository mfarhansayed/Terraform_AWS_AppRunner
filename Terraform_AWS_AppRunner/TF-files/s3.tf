resource "aws_s3_bucket" "project_name-portal-dev" {
  bucket = var.project_name-portal-bucket-name
  tags = {
    Name = "test-bucket"
  }
}


resource "aws_s3_bucket_public_access_block" "project_name-portal-dev-permissions" {
  bucket                  = aws_s3_bucket.project_name-portal-dev.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.project_name-portal-dev.id
  policy = data.aws_iam_policy_document.allow_access_from_apprunner.json
}

data "aws_iam_policy_document" "allow_access_from_apprunner" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["apprunner.amazonaws.com"]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"

    ]

    resources = [
      aws_s3_bucket.project_name-portal-dev.arn,
      "${aws_s3_bucket.project_name-portal-dev.arn}/*",
    ]
  }
}
