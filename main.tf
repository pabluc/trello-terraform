resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "instance" {
  name = "terraform-tcp-security-group"
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-0d5eff06f840b45e9"
  
  instance_type               = "t2.micro"

  tags = {
    Name = "TrelloApp"
  }

  vpc_security_group_ids = [aws_security_group.instance.id]

  key_name = aws_key_pair.deployer.key_name
}
