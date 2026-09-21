data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_key_pair" "fleet_key" {
  key_name   = "${var.app_name}-key"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

resource "aws_instance" "fleet_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.fleet_key.key_name
  vpc_security_group_ids = [aws_security_group.fleet_subnet_group.id]
  #user_data = file("user_data.sh")
  tags = {
    Name = "Fleet EC2"
  }
}