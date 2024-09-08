resource "aws_vpc" "vpc-1" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "vpc-1"
  }
}

resource "aws_internet_gateway" "gateway-1" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "gateway-1"
  }
}
resource "aws_egress_only_internet_gateway" "egressgate-1" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "egressgate-1"
  }
}

resource "aws_subnet" "subnet-public" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = var.subnet-public-cidr_block

  tags = {
    Name = "subnet-public"
  }
}

resource "aws_subnet" "subnet-private" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = var.subnet-private-cidr_block

  tags = {
    Name = "subnet-private"
  }
}

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway-1.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.egressgate-1.id
  }

  tags = {
    Name = "public-route"
  }
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.vpc-1.id

  route = []

  tags = {
    Name = "private-route"
  }
}

resource "aws_route_table_association" "public-route-table-association" {
  subnet_id      = aws_subnet.subnet-public.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "private-route-table-association" {
  subnet_id      = aws_subnet.subnet-private.id
  route_table_id = aws_route_table.private-route.id
}
resource "aws_security_group" "example" {
    name = "example"
    description = "allow inbound traffic on port 22"
    vpc_id = aws_vpc.vpc-1.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
      from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_instance" "instance-vpc" {
  count = var.create_ec2 ? var.count_ec2_instance : 0
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet-public.id
  vpc_security_group_ids = [ aws_security_group.example.id ]

  tags = {
    Name = "Poojitha2907"
  }
}