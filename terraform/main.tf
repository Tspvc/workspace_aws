provider "aws" {
  region  = "us-east-1"
  profile = "tspvc"
}

data "aws_ami" "centos" {
owners      = ["679593333241"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Linux 7 x86_64 HVM EBS ENA *"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

terraform {
  backend "s3" {
    bucket = "tspvc-remote-tfstates"
    key    = "personal/tfstate"
    region = "us-east-1"
  }
}
