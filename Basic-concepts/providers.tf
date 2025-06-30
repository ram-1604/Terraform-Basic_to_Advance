
#✅ What is a Provider?
# In Terraform, a provider is a plugin that defines how Terraform communicates with a given cloud platform, service, or API.
# Terraform itself is platform-agnostic.
# Providers enable it to interact with specific platforms like AWS, Azure, Google Cloud, Kubernetes, GitHub, etc.
# Every resource you define in Terraform is associated with a provider.

#🔧 How Providers Work
#  When you define a resource like:


resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
# Terraform looks for the AWS provider plugin to know how to create an EC2 instance.

# 🧱 Basic Provider Block Syntax

provider "<NAME>" {
  # Configuration options specific to the provider
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"   # optional, uses AWS CLI profile
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}
# 📁 Example Project Using Provider (AWS)
#🔹 main.tf

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-bucket-123456"
  acl    = "private"
}
#🔹 variables.tf

variable "aws_region" {
  default = "us-east-1"
}
#🔹 terraform.tfvars

# aws_region = "us-east-1"

# 🧩 Multiple Providers Example (e.g., AWS and GitHub)

provider "aws" {
  region = "us-east-1"
}

provider "github" {
  token = var.github_token
}
#You can use resources from both:

# resource "aws_instance" "web" { ... }

resource "github_repository" "demo" {
  name = "my-repo"
  visibility = "private"
}

#🧠 Advanced: Multiple AWS Accounts (Aliased Providers)
# When working with multiple AWS accounts, use aliases:


provider "aws" {
  alias  = "account_a"
  region = "us-east-1"
  profile = "account-a-profile"
}

provider "aws" {
  alias  = "account_b"
  region = "us-west-2"
  profile = "account-b-profile"
}

resource "aws_s3_bucket" "a" {
  provider = aws.account_a
  bucket   = "bucket-a"
}

resource "aws_s3_bucket" "b" {
  provider = aws.account_b
  bucket   = "bucket-b"
}