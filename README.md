# AWS Terraform + Ansible

Terraform + Ansible project for personal AWS workstation administration.

## Getting started

As a pre-requisite is necessary [AWS CLI][1] installed and configured, [terraform][2] and [ansible][3] on your environment.

Clone the project:

    $ git clone https://github.com/tspvc/workspace_aws
    $ cd workspace_aws

## Access Keys

This project uses Terraform to build the required resources and execute the ansible playbook on the EC2 Instance after creation. You have to configure your AWS credentials with permission to create the required resources.

    $ aws configure

## Usage

    $ cd terraform
    $ terraform init
    $ terraform apply
    
## Future improvements

Use variables everywhere!

[1]: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html
[2]: https://learn.hashicorp.com/terraform/getting-started/install.html
[3]: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
