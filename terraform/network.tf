data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "${var.app_name}-igw"
  }
}

resource "aws_route_table" "example" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.app_name}-route-table"
  }
}

resource "aws_route_table_association" "example" {
  subnet_id      = data.aws_subnets.default.ids[0]
  route_table_id = aws_route_table.example.id
}