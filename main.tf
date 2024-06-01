terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "remote" {
    organization = "alex27_Org"

    workspaces {
      name = "travel-expensetracker-tester"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "bucket2_react" {
  bucket = "my-s3-bucket-travelexpense-tester"

  tags = {
    Name        = "MyS3Bucket2"
  }
}


resource "aws_s3_object" "files" {
  bucket   = aws_s3_bucket.bucket2_react.id
  for_each = fileset("/Users/alexslone/Projects/travel-expense-tester/build/static", "**")
  key      = each.value
  source   = "/Users/alexslone/Projects/travel-expense-tester/build/static/${each.value}"
}
