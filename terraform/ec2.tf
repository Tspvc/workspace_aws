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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "workstation" {
  ami                         = "${data.aws_ami.amazon-linux-2.id}"
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
}
