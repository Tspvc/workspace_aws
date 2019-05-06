provider "aws" {
  region  = "us-east-1"
  profile = "tspvc"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

terraform {
  backend "s3" {
    bucket = "tspvc-remote-tfstates"
    key    = "personal/tfstate"
    region = "us-east-1"
  }
}
