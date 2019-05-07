resource "aws_security_group" "workstation" {
  name        = "workstation-sg"
  description = "Allow SSH to Workstation"
  vpc_id      = "vpc-daac1ebf"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 60000
    to_port     = 60050
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "workstation" {
#  ami                         = "${data.aws_ami.centos.id}"
  ami                         = "ami-02eac2c0129f6376b"
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  subnet_id                   = "subnet-d98c5fae"
  key_name                    = "Main"
  vpc_security_group_ids      = ["${aws_security_group.workstation.id}"]

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }

  tags = {
    Name = "Workstation"
  }

  provisioner "local-exec" {
    command = "sleep 80; ansible-playbook -u centos -i '${aws_instance.workstation.public_ip},' playbooks/main.yml"
  }
}

resource "aws_route53_record" "workstation" {
  zone_id = "ZWAML9R9AUBAL"
  name    = "ws"
  type    = "A"
  records = ["${aws_instance.workstation.public_ip}"]
  ttl     = 300
}
