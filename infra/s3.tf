resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Environment = "Dev"
  }
}

variable bucket_name {
  default = "joshi-psymmetry-dev"
  type = string
}
