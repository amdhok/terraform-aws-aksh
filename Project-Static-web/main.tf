terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "rand_id" {
    byte_length = 8
  
}

resource "aws_s3_bucket" "mywebapp" {
    bucket = "demo-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {
    bucket = aws_s3_bucket.mywebapp.id
    policy = jsonencode(
        {
    Version = "2012-10-17",		 	 	 
    Id = "ExamplePolicy01",
    Statement = [
        {
            Sid = "ExampleStatement01",
            Effect = "Allow",
            Principal = {
                AWS = "*"
            },
            Action = [
                "s3:GetObject",
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ],
            Resource = [
                "arn:aws:s3:::${aws_s3_bucket.mywebapp.id}/*",
                "arn:aws:s3:::${aws_s3_bucket.mywebapp.id}"
            ]
        }
    ]
}

    )    
    
  
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_file" {
    bucket = aws_s3_bucket.mywebapp.bucket
    source = "./index.html"
    key = "index.html"
    content_type = "text/html"
}

resource "aws_s3_object" "js_file" {
    bucket = aws_s3_bucket.mywebapp.bucket
    source = "./templatemo-quantix-script.js"
    key = "templatemo-quantix-script.js"
    content_type = "text/js"
}

resource "aws_s3_object" "CSS_file" {
    bucket = aws_s3_bucket.mywebapp.bucket
    source = "./templatemo-quantix-style.css"
    key = "templatemo-quantix-style.css"
    content_type = "text/css"
}

resource "aws_s3_object" "html_file" {
    bucket = aws_s3_bucket.mywebapp.bucket
    source = "./templates.html"
    key = "templates.html"
    content_type = "text/html"
}

output "output" {
    value = random_id.rand_id.hex
}

output "wesite_endpoint" {
    value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}