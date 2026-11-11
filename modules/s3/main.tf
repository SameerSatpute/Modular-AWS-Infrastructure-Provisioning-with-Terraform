resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucketname
  bucket_namespace = var.bucket_namespace

  tags = {
    Name        = "s3_bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "acl" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    id = "rule-1"

    filter {
      prefix = var.prefix
    }

    status = "Enabled"

    transition {
      days          = var.day
      storage_class = var.storage_class
    }

    expiration {
        days = var.days
    }

    noncurrent_version_expiration {
        noncurrent_days = var.noncurrent_days         
    }

  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}