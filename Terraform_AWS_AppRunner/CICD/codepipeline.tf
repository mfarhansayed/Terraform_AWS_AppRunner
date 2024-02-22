#------------------------ DEV -----------------------------------------------------------------

# ----------------------CODEPIPELINE BACKEND ---------------------------------------------------
resource "aws_codepipeline" "codepipeline_be" {
  count    = var.create_codepipeline_be == true ? 1 : 0
  name     = var.codepipeline_be_name
  role_arn = aws_iam_role.codepipeline_role[0].arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket_be[0].bucket
    type     = var.artifact_store_type_be

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = var.encryption_key_be
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName       = var.repo_name_be
        BranchName           = var.branch_be
        PollForSourceChanges = true

      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.backend[0].name
      }
    }
  }

  tags = {
    project = "project_name"
  }
}


resource "aws_s3_bucket" "codepipeline_bucket_be" {
  count         = var.create_s3_codepipeline_be == true ? 1 : 0
  bucket        = var.cp_bucket_be
  force_destroy = var.force_destroy_s3
  tags = {
    project = "project_name"
  }
}


data "aws_kms_alias" "s3kmskey" {
  name = var.s3kmskey_be
}


#-------------------------cp test-case------------------------------------------------------
resource "aws_codepipeline" "codepipeline_be-test" {
  count    = var.create_codepipeline_be-test == true ? 1 : 0
  name     = var.codepipeline_be-test_name
  role_arn = aws_iam_role.codepipeline_role[0].arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket_be-test[0].bucket
    type     = var.artifact_store_type_be

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = var.encryption_key_be
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName       = var.repo_name_be_test
        BranchName           = var.branch_be-test
        PollForSourceChanges = true

      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.test-backend[0].name
      }
    }
  }

  tags = {
    project = "project_name"
  }
}


resource "aws_s3_bucket" "codepipeline_bucket_be-test" {
  count         = var.create_s3_codepipeline_be-test == true ? 1 : 0
  bucket        = var.cp_bucket_be-test
  force_destroy = var.force_destroy_s3
  tags = {
    project = "project_name"
  }
}

data "aws_kms_alias" "s3kmskey_be" {
  name = var.s3kmskey_be-test
}



# ----------------------CODEPIPELINE FRONTEND ---------------------------------------------------
resource "aws_codepipeline" "codepipeline_fe" {
  count    = var.create_codepipeline_fe == true ? 1 : 0
  name     = var.codepipeline_fe_name
  role_arn = aws_iam_role.codepipeline_role[0].arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket_fe[0].bucket
    type     = var.artifact_store_type_fe

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = var.encryption_key_fe
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName       = var.repo_name_fe
        BranchName           = var.branch_fe
        PollForSourceChanges = true

      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.frontend[0].name
      }
    }
  }

  tags = {
    project = "project_name"
  }
}


resource "aws_s3_bucket" "codepipeline_bucket_fe" {
  count         = var.create_s3_codepipeline_fe == true ? 1 : 0
  bucket        = var.cp_bucket_fe
  force_destroy = var.force_destroy_s3
  tags = {
    project = "project_name"
  }

}

data "aws_kms_alias" "s3kmskey_fe" {
  name = var.s3kmskey_fe
}


#---------------------------------------- UAT ---------------------------------------------------------------

# ----------------------     UAT CODEPIPELINE BACKEND  ---------------------------------------------------------

resource "aws_codepipeline" "codepipeline_be_uat" {
  count    = var.create_codepipeline_be_uat == true ? 1 : 0
  name     = var.codepipeline_be_uat_name
  role_arn = aws_iam_role.codepipeline_role[0].arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket_be_uat[0].bucket
    type     = var.artifact_store_type_be_uat

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = var.encryption_key_be_uat
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName       = var.repo_name_be_uat
        BranchName           = var.branch_be_uat
        PollForSourceChanges = true

      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.backend_uat[0].name
      }
    }
  }

  tags = {
    project = "project_name"
  }
}


resource "aws_s3_bucket" "codepipeline_bucket_be_uat" {
  count         = var.create_s3_codepipeline_be_uat == true ? 1 : 0
  bucket        = var.cp_bucket_be_uat
  force_destroy = var.force_destroy_s3_uat
  tags = {
    project = "project_name"
  }
}

data "aws_kms_alias" "s3kmskey_be_uat" {
  name = var.s3kmskey_be_uat
}


# ---------------------- UAT CODEPIPELINE FRONTEND ---------------------------------------------------
resource "aws_codepipeline" "codepipeline_fe_uat" {
  count    = var.create_codepipeline_fe_uat == true ? 1 : 0
  name     = var.codepipeline_fe_uat_name
  role_arn = aws_iam_role.codepipeline_role[0].arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket_fe_uat[0].bucket
    type     = var.artifact_store_type_fe_uat

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = var.encryption_key_fe_uat
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName       = var.repo_name_fe_uat
        BranchName           = var.branch_fe_uat
        PollForSourceChanges = true

      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.frontend_uat[0].name
      }
    }
  }

  tags = {
    project = "project_name"
  }
}


resource "aws_s3_bucket" "codepipeline_bucket_fe_uat" {
  count         = var.create_s3_codepipeline_fe_uat == true ? 1 : 0
  bucket        = var.cp_bucket_fe_uat
  force_destroy = var.force_destroy_s3
  tags = {
    project = "project_name"
  }

}

data "aws_kms_alias" "s3kmskey_fe_uat" {
  name = var.s3kmskey_fe_uat
}