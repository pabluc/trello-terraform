resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDO53P4hoMUZ90XgrERf5Un1y16UrHml+o8JgDqxaePI2OuUwh1hQD7uMEOYPxcI5nnlA0cv55FITP6MM5JWb7NI8yH96Vpyzo/npiKyhCCdYbilj6mQ9iHb9GiRhONiTh32LSkILkZClfHOInD/gO/aeiRPaFP1zE/xIpDDBuyTjSMDvpiWM87nsvFisE1JaMxDYoVE3GS7eERoqnVgyY++ZfguNOYc+S0hlrXTjk60n2ijaCbiZl3xM6omTgBjkAUM7MOUREH3XSgVHCBFuVrWxf/2jhMQqGR0BMO8gyUiBBn/Cl1MblVQnRVrhlSqwgmJrBF7ACbO9R36OCrYc1mQLK4wf3dMjo9hut9smUCPtCSOTFWZrMgRA/ED6Q5C8aIDcGw4us5pFJnmmVSTyYOcLZo7YFwOuQVYO384RQCCHBsknmq5CRMHG+3xtlNgz7lX+2nYnxfVkssrGzCpwFGpjictpZcGu2hi8wuuEuVg1+wV4bbKByAXwFy2XD+WZXhMgo4R8oaoF1seErSo6HoJVa1rKgxN9jNZZNZ/b7Kykc+2fTzt784hwJpsVhi2uaOk/SXXkd9gsLkl+PHaJt1RydGMdcv0BzabFDeFexfIJ1wy+RSsXQX9/WKdTS3+PUZef570qJWnetgM0CA9KWCUN8cUIrX07HwsqfGc/bEaw== pablo@backlotcars.com"
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
